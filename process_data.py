import os


OUTPUT_DIR = "output_files"  
SUMMARY_FILE = "test_summary.txt"

CPU_KEYWORDS = ["CPU burst"]

with open(SUMMARY_FILE, "w") as summary:
    summary.write("Filename: Total, Ratio (IO/Duration) IO, CPU, IO/CPU\n")  

    for root, dirs, files in os.walk(OUTPUT_DIR):
        for filename in files:
            filepath = os.path.join(root, filename)

            total_time = 0
            cpu_time = 0
            io_time = 0

            with open(filepath, "r") as f:
                for line in f:
                    parts = line.strip().split(",")
                    if len(parts) < 2:
                        continue
                    try:
                        duration = float(parts[1].strip())
                    except ValueError:
                        continue
                    activity_desc = parts[2].strip() if len(parts) > 2 else ""

                    total_time += duration

                    if any(keyword in activity_desc for keyword in CPU_KEYWORDS):
                        cpu_time += duration
                    else:
                        io_time += duration

            summary.write(f"{filename}: Total={total_time:.0f}, Ratio {io_time/total_time:.2f}, IO={io_time:.0f}, CPU={cpu_time:.0f}\n")

print(f"Summary written to {SUMMARY_FILE}")
