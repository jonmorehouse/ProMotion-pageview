def debug(*args)
  args << "NIL DEBUG MESSAGE" if args.empty? or args.first.nil?

  puts "\n\n"
  args.each {|arg| puts arg }
  puts "\n\n"
end
