class TextAnalyzer
  attr_reader :text
  def initialize(text)
    @text = text
  end

  def word_counts
    text.split(" ").reduce({}) do |final, word|
      final[word] = (final[word] || 0) + 1
      final
    end
  end

  def character_counts
    text.split("").reduce({}) do |final, character|
      final[character] = (final[character] || 0) + 1
      final
    end
  end

  def big_words(length = 10)
    words.select { |word| word.length > length }.uniq.join(", ")
  end

  def small_words(length = 5)
    words.select { |word| word.length < length }.uniq.join(", ")
  end

  def most_frequent_word
    word_counts.max_by { |word, count| count }.join(": ")
  end

  def word_with_most_vowels
    words.max_by { |word| word.scan(/[aeiou]/).length }
  end

  def word_with_fewest_vowels
    words.min_by { |word| word.scan(/[aeiou]/).length }
  end

  def top_words(number = 5)
    word_counts.sort_by { |word, count| count }.last(number).map { |pair| pair.join(": ") }.join(', ')
  end

  def average_word_length
    words.map { |word| word.length }.reduce(:+) / words.length
  end

  def sentence_count
    sentences.count
  end

  def sentence_with_most_words
    sentence = sentences.max_by { |sentence| sentence.split(" ").count }
    [sentences.index(sentence), sentence.split(" ").count]
  end

  def paragraph_count
    paragraphs.count
  end

  def paragraph_with_most_words
    paragraph = paragraphs.max_by { |text| text.split(" ").count }
    [paragraphs.index(paragraph), paragraph.split(" ").count]
  end

  def words_with_even_chars
    words.select { |word| word.length.even? }
  end

  def words_with_odd_chars
    words.reject { |word| word.length.even? }
  end

  private

  def words
    text.split(" ")
  end

  def sentences
    text.split(". ")
  end

  def paragraphs
    text.split("\n\n")
  end
end
