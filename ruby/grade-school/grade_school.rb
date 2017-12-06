require 'pry'

class School
  def initialize
    @students = Hash.new([])
  end

  def add(name, position)
    @students["#{position}"] += [name]
  end

  def students(position)
    @students["#{position}"].sort_by{|k, v| k}
  end

  def students_by_grade
    return [] if @students.empty?
    @students.sort_by{|el| el.first}.map do |k, v|
      { grade: k.to_i, students: v.sort_by {|i| i} }
    end
  end
end

module BookKeeping; VERSION=3; end
