require "text_analytics"
require 'pry-state'

RSpec.describe TextAnalytics do
  let(:text) { File.read("./data/hipster_ipsum.txt") }
  subject { TextAnalytics.new(text) }

  describe "#word_counts" do
    it "returns a hash of word keys pointing to frequency count" do
      words = "me me you you you them"
      analyzer = TextAnalytics.new(words)
      expected = {
        "you" => 3,
        "me" => 2,
        "them" => 1
      }
      word_counts = analyzer.word_counts
      expect(word_counts).to eq expected
    end
  end

  describe "#big_words" do
    it "returns a collection of words greater than 10 characters" do
      big_words = subject.big_words
      expected = (
        "post-ironic, Cold-pressed, chicharrones, williamsburg, flexitarian, thundercats, letterpress, microdosing., single-origin, Microdosing, cold-pressed, fingerstache, Asymmetrical, microdosing, church-key., succulents,, vexillologist, lumbersexual, farm-to-table,, intelligentsia"
      )
      expect(big_words).to eq expected
    end

    it "and character length can be modified" do
      big_words = subject.big_words(12)
      expected = "single-origin, vexillologist, farm-to-table,, intelligentsia"
      expect(big_words).to eq expected
    end
  end

  describe "#small_words" do
    it "returns a collection of words fewer than 5 characters" do 
      small_words = subject.small_words 
      expected = (
        "hot, tbh, fam,, banh, mi, Art, you, of, them, Wolf, bag, +1, jean, axe, XOXO, cray, YOLO, raw, mi,, kogi, swag, meh., poke, pin, bulb, art, la, fam, food, yr, cred, goth, Kogi, fap, chia, wolf, DIY, tote, put, a, bird, on, it, lomo, air, they, sold, out, ugh, Tbh, meh, mug, book, hell, of."
      )
      expect(small_words).to eq expected
    end

    it "and character length can be modified" do
      small_words = subject.small_words(2)
      expected = "a"
      expect(small_words).to eq expected
    end
  end

  describe "#most_frequent_word" do
    it "returns most frequent word" do
      expect(subject.most_frequent_word).to eq "post-ironic: 3"
    end
  end

  describe "#word_with_most_vowels" do
    it "returns word with most vowels" do
      expect(subject.word_with_most_vowels).to eq "intelligentsia"
    end
  end

  describe "#word_with_fewest_vowels" do
    it "returns word with fewest vowels" do
      expect(subject.word_with_fewest_vowels).to eq "tbh"
    end
  end

  describe "#top_words" do
    it "returns the top 5 words by default" do
      expect(subject.top_words).to eq "art: 3, party: 3, banh: 3, food: 3, post-ironic: 3"
    end

    it "and the amount can be modified" do
      expect(subject.top_words(3)).to eq "banh: 3, food: 3, post-ironic: 3"
    end
  end

  describe "#average_word_length" do
    it "returns the word length" do
      expect(subject.average_word_length).to eq 6
    end
  end

  describe "#sentence_count" do
    it "returns the number of sentences" do
      expect(subject.sentence_count).to eq 25
    end
  end

  describe "#sentence_with_most_words" do
    it "returns index of sentence with most words and word count" do
      expect(subject.sentence_with_most_words).to eq [6, 22]
    end
  end

  describe "#paragraph_count" do
    it "returns the number of paragraphs" do
      expect(subject.paragraph_count).to eq 4
    end
  end

  describe "#paragraph_with_most_words" do
    it "returns index of paragraph with most words and word count" do
      expect(subject.paragraph_with_most_words).to eq [3, 113]
    end
  end
end
