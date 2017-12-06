module Complement

  DNA_STRAND_MATRIX = {
    "C" => "G",
    "G" => "C",
    "T" => "A",
    "A" => "U"
  }

  def self.of_dna(dna_strand)
    split_dna_strand = dna_strand.split("")

    return "" unless split_dna_strand.all? { |single_strand| DNA_STRAND_MATRIX["#{single_strand}"] }
    split_dna_strand.map { |single_strand| DNA_STRAND_MATRIX["#{single_strand}"] }.join
  end
end

module BookKeeping
  VERSION = 4
end
