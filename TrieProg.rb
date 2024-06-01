# Author: Khang Tran
# Implement a standard trie. Contain an interactive program for using the trie class to
# search for strings in files. Start by asking the user for a file name. 
# When that filename is given, the program should open it and build a trie from that file.
# User should be able to input strings to search:
# If the string that is entered is not in the text, print a statement saying that the string is not found
# If the string is a full word in the text, the program should print out all
# locations at which the string occurs. The location should indicate line number and word number.
# If the string is a prefix for any words in the text, 
# the program should print out all the strings that occur in the text that start with that prefix
# If the input string is both a full word and a prefix, print the locations of the full word.
# Type :q to exit the program.
class Trie
    attr_accessor :root
  
    def initialize(root)
      @root = root
    end
  
    def processFile(file)
        lineNum = 0
        File.open(file, 'r') do |f|
            f.each_line do |line|
                lineNum += 1
                wordPos = -1
                words = line.split(" ")
                words.each do |word|
                    wordPos +=1
                    insert(word, lineNum, wordPos) 
                end
            end
        end
    end
  
    def insert(word,lineNum, wordPos)
        node = @root
        word.chars.each_with_index do |char,index|
            child = node.children.find { |c| c.value == char }
            if child.nil?
                child = TreeNode.new(char)
                node.children << child
            end
            node = child
            if index == word.length - 1
                child.line << lineNum
                child.position << wordPos
            end
        end
    end
  

    def search(word)
        result = ""
        node = @root
        word.chars.each_with_index do |char,index|
            child = node.children.find { |c| c.value == char }
            if !child.nil?
                result += "#{child.value}"
                node = child
            elsif child.nil?
                puts "Not found."
                break
            end

            if index == word.length - 1
                if !node.line.empty?
                    node.line.zip(node.position).each do |line, position|
                        puts "(#{line}, #{position})"
                    end
                else
                    searchAll(result, node)
                end
            end
        end
    end

    def searchAll(prefix, node)
        if !node.line.empty? && !node.position.empty?
            puts "#{prefix}"
        end
        node.children.each do |child|
            searchAll(prefix + child.value, child)
        end
    end
end
  
  # TreeNode class for representing each node in the Trie
class TreeNode
    attr_accessor :value, :children, :line, :position
  
    def initialize(value)
      @value = value
      @children = []
      @line = []
      @position = []
    end
end
  
puts "Type the name of your file:"
input = gets.chomp
trie = Trie.new(TreeNode.new(""))
trie.processFile(input)
while true
    puts "Type a string to search for."
    str = gets.chomp
    break if str == ":q"
    trie.search(str)
end