# frozen_string_literal: true

TASKLIST_PATH = File.join(__dir__, "TASKLIST.md")
STATUS_COLUMNS = ["動作確認", "パラメーター改善", "シェーダー化・最適化"].freeze

def tasklist_rows
  File.readlines(TASKLIST_PATH, chomp: true, encoding: "UTF-8").filter_map do |line|
    next unless line.start_with?("|")

    cells = line.split("|", -1).map(&:strip)
    cells.shift
    cells.pop

    next if cells.empty?
    next if cells[0] == "カテゴリ"
    next if cells.all? { |cell| cell.match?(/\A-+\z/) }

    {
      category: cells[0],
      script: cells[1],
      statuses: STATUS_COLUMNS.zip(cells[2, STATUS_COLUMNS.size]).to_h
    }
  end
end

def summarize_statuses(rows)
  summary = {
    total_scripts: rows.size,
    total_checks: 0,
    completed_checks: 0,
    pending_checks: 0,
    ignored_checks: 0,
    columns: STATUS_COLUMNS.to_h { |column| [column, { completed: 0, pending: 0, ignored: 0 }] }
  }

  rows.each do |row|
    row[:statuses].each do |column, status|
      column_summary = summary[:columns][column]

      case status
      when ":o:"
        summary[:total_checks] += 1
        summary[:completed_checks] += 1
        column_summary[:completed] += 1
      when ":x:"
        summary[:total_checks] += 1
        summary[:pending_checks] += 1
        column_summary[:pending] += 1
      else
        summary[:ignored_checks] += 1
        column_summary[:ignored] += 1
      end
    end
  end

  summary
end

def progress_percent(completed, total)
  return "0.0%" if total.zero?

  format("%.1f%%", completed.fdiv(total) * 100)
end

class String
  # ASCII 文字は幅1、絵文字や全角文字は幅2とみなして表示幅を計算
  def pseudo_display_width
    each_char.sum do |char|
      if char.ascii_only?
        1
      else
        2
      end
    end
  end

  # 指定した幅に合わせてスペースで右側を埋める（絵文字や全角文字を考慮）
  def pseudo_ljust(width)
    padding = [0, width - pseudo_display_width].max
    self + " " * padding
  end
end

def print_progress_table(title, rows, headers)
  widths = headers.map.with_index do |header, index|
    [header.pseudo_display_width, rows.map { |row| row[index].to_s.pseudo_display_width }.max].max
  end

  puts title
  puts headers.each_with_index.map { |header, index| header.pseudo_ljust(widths[index]) }.join("  ")
  puts widths.map { |width| "-" * width }.join("  ")
  rows.each do |row|
    puts row.each_with_index.map { |cell, index| cell.to_s.pseudo_ljust(widths[index]) }.join("  ")
  end
end

desc "TASKLIST.md の現在の進捗状況を表示する"
task :current_progress do
  abort "TASKLIST.md が見つかりません: #{TASKLIST_PATH}" unless File.exist?(TASKLIST_PATH)

  rows = tasklist_rows
  summary = summarize_statuses(rows)

  column_rows = summary[:columns].map do |column, counts|
    total = counts[:completed] + counts[:pending]
    [
      column,
      counts[:completed],
      counts[:pending],
      counts[:ignored],
      progress_percent(counts[:completed], total)
    ]
  end

  print_progress_table(
    "現在の進捗状況",
    column_rows,
    ["項目", "完了", "未完了", "対象外", "進捗率"]
  )
end
