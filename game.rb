# encoding: utf-8
#
# Основной класс игры Game. Хранит состояние игры и предоставляет функции для
# развития игры (ввод новых букв, подсчет кол-ва ошибок и т. п.).
class Game
  def initialize(slovo)
    @letters = get_letters(slovo)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = 0
  end

  def get_letters(slovo)
    if slovo.nil? || slovo == ""
      abort "Задано пустое слово, не о чем играть. Закрываемся."
    else
      slovo = slovo.encode("UTF-8")
    end

    UnicodeUtils.upcase(slovo).split('')
  end

  def status
    @status
  end

  def check_for_double_letter(array, bukva)
    array << "Й" if bukva == "И"
    array << "И" if bukva == "Й"
    array << "Ё" if bukva == "Е"
    array << "Е" if bukva == "Ё"
  end

  def next_step(bukva)
    bukva = UnicodeUtils.upcase(bukva)

    return if @status == -1 || @status == 1
    return if @good_letters.include?(bukva) || @bad_letters.include?(bukva)

    if @letters.include?(bukva) ||
       (bukva == "Е" && @letters.include?("Ё")) ||
       (bukva == "Ё" && @letters.include?("Е")) ||
       (bukva == "И" && @letters.include?("Й")) ||
       (bukva == "Й" && @letters.include?("И"))
      @good_letters << bukva

      check_for_double_letter(@good_letters, bukva)

      @status = 1 if (@letters - @good_letters).empty?
    else
      @bad_letters << bukva

      check_for_double_letter(@bad_letters, bukva)

      @errors += 1

      @status = -1 if @errors >= 7
    end
  end

  def ask_next_letter
    puts "\nВведите следующую букву"
    letter = ""

    while letter == ""
      letter = STDIN.gets.encode("UTF-8").chomp
    end

    next_step(letter)
  end

  def errors
    @errors
  end

  def letters
    @letters
  end

  def good_letters
    @good_letters
  end

  def bad_letters
    @bad_letters
  end
end
