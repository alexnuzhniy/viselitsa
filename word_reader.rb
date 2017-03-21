# encoding: utf-8
#
# Класс WordReader, отвечающий за чтение слова для игры.
class WordReader
  def read_from_args
    ARGV[0]
  end

  def read_from_file(file_name)
    return nil if !File.exist?(file_name)

    lines = File.readlines(file_name)

    lines.sample.chomp
  end
end
