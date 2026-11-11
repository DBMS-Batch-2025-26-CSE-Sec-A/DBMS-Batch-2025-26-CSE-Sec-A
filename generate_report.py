import os
import re
import zipfile
from collections import defaultdict
from datetime import datetime
import openpyxl
from openpyxl.styles import Font, PatternFill, Alignment, Border, Side
from openpyxl.utils import get_column_letter

# ================= CONFIGURATION =================
# "." scans the current GitHub repository root directory directly
SOURCE_PATH = "."
OUTPUT_EXCEL = "Lab_Submission_Report.xlsx"

# Ignore non-assignment placeholder files
IGNORED_FILES = {".gitkeep", ".ds_store", "thumbs.db", ".gitignore"}
# =================================================

# Matches MM-DD-YYYY, DD-MM-YYYY, or YYYY-MM-DD (also tolerates 5-digit year typos like 11-13-20226)
DATE_REGEX = re.compile(r"^(\d{2}[-_]\d{2}[-_]\d{4,5}|\d{4,5}[-_]\d{2}[-_]\d{2})$")
# Used ONLY to detect all valid Roll Numbers from workflow if present (usernames are discarded)
WORKFLOW_ROLL_REGEX = re.compile(r'\["[^"]+"\]\s*=\s*"(\d+)"')

def parse_date_safe(date_str):
    """Parses common date folder formats for chronological sorting."""
    norm = date_str.replace("_", "-")
    parts = norm.split("-")
    if len(parts) == 3 and len(parts[2]) == 5 and parts[2].startswith("202"):
        norm = f"{parts[0]}-{parts[1]}-{parts[2][:3]}{parts[2][4:]}"
    for fmt in ("%m-%d-%Y", "%d-%m-%Y", "%Y-%m-%d"):
        try:
            return datetime.strptime(norm, fmt)
        except ValueError:
            continue
    return datetime.min

def load_entries_and_rolls(source_path):
    """Reads file paths and extracts the list of roll numbers (ignoring usernames)."""
    entries = []
    known_rolls = set()

    if os.path.isfile(source_path) and zipfile.is_zipfile(source_path):
        with zipfile.ZipFile(source_path, "r") as z:
            raw_entries = z.namelist()
            for name in raw_entries:
                if ".github/workflows/" in name and name.endswith((".yml", ".yaml")):
                    content = z.read(name).decode("utf-8", errors="ignore")
                    for roll in WORKFLOW_ROLL_REGEX.findall(content):
                        known_rolls.add(f"{int(roll):02d}")

            first_segments = {e.split("/")[0] for e in raw_entries if e.strip()}
            strip_root = len(first_segments) == 1 and not DATE_REGEX.match(next(iter(first_segments)))

            for e in raw_entries:
                parts = [p for p in e.split("/") if p]
                if strip_root and parts:
                    parts = parts[1:]
                if parts:
                    entries.append(("/".join(parts) + ("/" if e.endswith("/") else "")))
    else:
        for root, dirs, files in os.walk(source_path):
            if ".git" in dirs:
                dirs.remove(".git")

            rel_root = os.path.relpath(root, source_path).replace("\\", "/")
            if rel_root != ".":
                entries.append(rel_root + "/")
            for f in files:
                full_path = os.path.join(root, f)
                rel_file = os.path.join(rel_root, f).replace("\\", "/")
                if rel_file.startswith("./"):
                    rel_file = rel_file[2:]
                entries.append(rel_file)

                if ".github/workflows/" in rel_file and rel_file.endswith((".yml", ".yaml")):
                    with open(full_path, "r", encoding="utf-8", errors="ignore") as wf:
                        for roll in WORKFLOW_ROLL_REGEX.findall(wf.read()):
                            known_rolls.add(f"{int(roll):02d}")

    return entries, known_rolls

def analyze_repository(source_path):
    entries, roll_set = load_entries_and_rolls(source_path)
    data = defaultdict(lambda: defaultdict(list))
    folder_exists = defaultdict(lambda: defaultdict(bool))
    date_set = set()

    for entry in entries:
        parts = [p for p in entry.split("/") if p]
        if not parts:
            continue

        # Level 1: Check if it is a Date Folder
        first = parts[0]
        if not DATE_REGEX.match(first):
            continue

        date_str = first
        date_set.add(date_str)

        # Level 2: Check if inside Date Folder there is a numeric Roll Number folder
        if len(parts) >= 2 and parts[1].isdigit():
            roll_padded = f"{int(parts[1]):02d}"
            roll_set.add(roll_padded)
            folder_exists[roll_padded][date_str] = True

            # Level 3+: Any files directly inside Roll folder OR inside nested subfolders
            if len(parts) >= 3 and not entry.endswith("/"):
                filename = parts[-1]
                if filename.lower() not in IGNORED_FILES:
                    rel_filename = "/".join(parts[2:])
                    data[roll_padded][date_str].append(rel_filename)

    sorted_dates = sorted(date_set, key=parse_date_safe)
    sorted_rolls = sorted(roll_set, key=lambda r: int(r))
    return data, folder_exists, sorted_dates, sorted_rolls

def build_universal_excel(data, folder_exists, sorted_dates, sorted_rolls, output_file):
    wb = openpyxl.Workbook()

    # Palette & Styles
    DARK_HEADER = PatternFill(start_color="1E293B", end_color="1E293B", fill_type="solid")
    SUB_HEADER = PatternFill(start_color="334155", end_color="334155", fill_type="solid")
    BANNER_FILL = PatternFill(start_color="0F172A", end_color="0F172A", fill_type="solid")
    ZEBRA_FILL = PatternFill(start_color="F8FAFC", end_color="F8FAFC", fill_type="solid")
    WHITE_FILL = PatternFill(start_color="FFFFFF", end_color="FFFFFF", fill_type="solid")
    DASH_FILL = PatternFill(start_color="FFF1F2", end_color="FFF1F2", fill_type="solid")
    ACTIVE_FILL = PatternFill(start_color="F0FDFA", end_color="F0FDFA", fill_type="solid")

    FONT_BANNER = Font(name="Calibri", size=13, bold=True, color="FFFFFF")
    FONT_HEADER = Font(name="Calibri", size=11, bold=True, color="FFFFFF")
    FONT_BOLD = Font(name="Calibri", size=10, bold=True, color="0F172A")
    FONT_REGULAR = Font(name="Calibri", size=10, color="1E293B")
    FONT_DASH = Font(name="Calibri", size=10, bold=True, color="E11D48")
    FONT_ACTIVE = Font(name="Calibri", size=10, bold=True, color="0F766E")

    THIN_BORDER = Border(
        left=Side(style="thin", color="CBD5E1"), right=Side(style="thin", color="CBD5E1"),
        top=Side(style="thin", color="CBD5E1"), bottom=Side(style="thin", color="CBD5E1")
    )

    # 1. Master Summary Sheet
    ws_master = wb.active
    ws_master.title = "Master_Summary"

    headers = ["Roll"] + sorted_dates + ["Days Submitted", "Total Files"]
    total_cols = len(headers)

    ws_master.merge_cells(start_row=1, start_column=1, end_row=1, end_column=total_cols)
    ws_master["A1"] = "Lab Submission Tracker"
    ws_master["A1"].font = FONT_BANNER
    ws_master["A1"].fill = BANNER_FILL
    ws_master["A1"].alignment = Alignment(horizontal="left", vertical="center", indent=1)
    ws_master.row_dimensions[1].height = 28

    ws_master.append(headers)
    ws_master.row_dimensions[2].height = 24
    for col_idx in range(1, total_cols + 1):
        c = ws_master.cell(row=2, column=col_idx)
        c.font = FONT_HEADER
        c.fill = DARK_HEADER
        c.alignment = Alignment(horizontal="center", vertical="center")
        c.border = THIN_BORDER
        c.number_format = "@"

    date_start_col = 2
    row_num = 3

    for roll in sorted_rolls:
        days_submitted = 0
        total_files = 0

        c_roll = ws_master.cell(row=row_num, column=1, value=str(roll))
        c_roll.number_format = "@"
        c_roll.font = FONT_BOLD
        c_roll.alignment = Alignment(horizontal="center", vertical="center")

        for d_idx, d_str in enumerate(sorted_dates):
            col_c = date_start_col + d_idx
            f_count = len(data[roll][d_str])
            cell = ws_master.cell(row=row_num, column=col_c)
            if f_count > 0:
                cell.value = f_count
                cell.number_format = '0" files";0" files";"-"'
                cell.font = FONT_ACTIVE
                cell.fill = ACTIVE_FILL
                days_submitted += 1
                total_files += f_count
            else:
                cell.value = "-"
                cell.number_format = "@"
                cell.font = FONT_DASH
                cell.fill = DASH_FILL
            cell.alignment = Alignment(horizontal="center", vertical="center")

        c_days = ws_master.cell(row=row_num, column=date_start_col + len(sorted_dates), value=days_submitted)
        c_days.font = FONT_BOLD
        c_days.alignment = Alignment(horizontal="center", vertical="center")
        c_days.number_format = f'0" / {len(sorted_dates)}"'

        c_tot = ws_master.cell(row=row_num, column=date_start_col + len(sorted_dates) + 1, value=total_files)
        c_tot.font = FONT_BOLD
        c_tot.alignment = Alignment(horizontal="center", vertical="center")
        c_tot.number_format = '0" files"'

        base_fill = ZEBRA_FILL if row_num % 2 == 0 else WHITE_FILL
        meta_cols = [1, date_start_col + len(sorted_dates), date_start_col + len(sorted_dates) + 1]
        for col_i in meta_cols:
            ws_master.cell(row=row_num, column=col_i).fill = base_fill
        for col_i in range(1, total_cols + 1):
            ws_master.cell(row=row_num, column=col_i).border = THIN_BORDER

        ws_master.row_dimensions[row_num].height = 19
        row_num += 1

    ws_master.column_dimensions["A"].width = 10
    for d_idx in range(len(sorted_dates)):
        ws_master.column_dimensions[get_column_letter(date_start_col + d_idx)].width = 14
    ws_master.column_dimensions[get_column_letter(date_start_col + len(sorted_dates))].width = 16
    ws_master.column_dimensions[get_column_letter(date_start_col + len(sorted_dates) + 1)].width = 15
    ws_master.freeze_panes = "B3"

    # 2. Individual Roll Number Sheets ("01", "02", ...)
    for roll in sorted_rolls:
        ws_roll = wb.create_sheet(title=str(roll))

        ws_roll.merge_cells("A1:E1")
        ws_roll["A1"] = f"Roll Number: {roll}"
        ws_roll["A1"].font = FONT_BANNER
        ws_roll["A1"].fill = BANNER_FILL
        ws_roll["A1"].alignment = Alignment(horizontal="left", vertical="center", indent=1)
        ws_roll.row_dimensions[1].height = 26

        ws_roll.cell(row=3, column=1, value="Roll").font = FONT_HEADER
        ws_roll.cell(row=3, column=1).fill = DARK_HEADER
        ws_roll.cell(row=3, column=1).alignment = Alignment(horizontal="center", vertical="center")
        ws_roll.cell(row=3, column=1).border = THIN_BORDER

        ws_roll.cell(row=4, column=1, value=str(roll)).number_format = "@"
        ws_roll.cell(row=4, column=1).font = FONT_BOLD
        ws_roll.cell(row=4, column=1).alignment = Alignment(horizontal="center", vertical="center")
        ws_roll.cell(row=4, column=1).border = THIN_BORDER

        for d_idx, d_str in enumerate(sorted_dates):
            col_c = 2 + d_idx
            hdr = ws_roll.cell(row=3, column=col_c, value=str(d_str))
            hdr.number_format = "@"
            hdr.font = FONT_HEADER
            hdr.fill = DARK_HEADER
            hdr.alignment = Alignment(horizontal="center", vertical="center")
            hdr.border = THIN_BORDER

            f_cnt = len(data[roll][d_str])
            val = ws_roll.cell(row=4, column=col_c)
            if f_cnt > 0:
                val.value = f_cnt
                val.number_format = '0" files"'
                val.font = FONT_ACTIVE
                val.fill = ACTIVE_FILL
            else:
                val.value = "-"
                val.number_format = "@"
                val.font = FONT_DASH
                val.fill = DASH_FILL
            val.alignment = Alignment(horizontal="center", vertical="center")
            val.border = THIN_BORDER

        detail_headers = ["Date Folder", "Folder Status", "File Count", "Formatted Count", "Submitted Files Inside Roll Folder"]
        for col_i, h_text in enumerate(detail_headers, start=1):
            c = ws_roll.cell(row=6, column=col_i, value=h_text)
            c.font = FONT_HEADER
            c.fill = SUB_HEADER
            c.alignment = Alignment(horizontal="center" if col_i < 5 else "left", vertical="center")
            c.border = THIN_BORDER

        r_idx = 7
        for d_str in sorted_dates:
            files_list = sorted(data[roll][d_str])
            f_cnt = len(files_list)
            has_folder = folder_exists[roll][d_str]

            c_date = ws_roll.cell(row=r_idx, column=1, value=str(d_str))
            c_date.number_format = "@"
            c_date.font = FONT_BOLD
            c_date.alignment = Alignment(horizontal="center", vertical="center")

            c_status = ws_roll.cell(row=r_idx, column=2)
            c_num = ws_roll.cell(row=r_idx, column=3)
            c_fmt = ws_roll.cell(row=r_idx, column=4)
            c_files = ws_roll.cell(row=r_idx, column=5)

            if f_cnt > 0:
                c_status.value = "Submitted"
                c_status.font = FONT_ACTIVE
                c_status.fill = ACTIVE_FILL
                c_num.value = f_cnt
                c_num.font = FONT_BOLD
                c_fmt.value = f"{f_cnt} files" if f_cnt != 1 else "1 file"
                c_fmt.font = FONT_ACTIVE
                c_fmt.fill = ACTIVE_FILL
                c_files.value = ", ".join(files_list)
                c_files.font = FONT_REGULAR
            else:
                c_status.value = "Empty Folder" if has_folder else "No Folder (-)"
                c_status.font = FONT_DASH
                c_status.fill = DASH_FILL
                c_num.value = 0
                c_num.font = FONT_REGULAR
                c_fmt.value = "-"
                c_fmt.font = FONT_DASH
                c_fmt.fill = DASH_FILL
                c_files.value = "-"
                c_files.font = FONT_DASH

            c_status.alignment = Alignment(horizontal="center", vertical="center")
            c_num.alignment = Alignment(horizontal="center", vertical="center")
            c_fmt.alignment = Alignment(horizontal="center", vertical="center")
            c_files.alignment = Alignment(horizontal="left", vertical="center")

            for col_i in range(1, 6):
                ws_roll.cell(row=r_idx, column=col_i).border = THIN_BORDER
            r_idx += 1

        ws_roll.column_dimensions["A"].width = 15
        ws_roll.column_dimensions["B"].width = 16
        ws_roll.column_dimensions["C"].width = 14
        ws_roll.column_dimensions["D"].width = 16
        ws_roll.column_dimensions["E"].width = 65

    wb.save(output_file)
    print(f"Done! Created '{output_file}' with {len(sorted_rolls)} roll sheets across {len(sorted_dates)} dates.")

if __name__ == "__main__":
    data, folder_exists, sorted_dates, sorted_rolls = analyze_repository(SOURCE_PATH)
    build_universal_excel(data, folder_exists, sorted_dates, sorted_rolls, OUTPUT_EXCEL)
