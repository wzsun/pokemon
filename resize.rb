#!/usr/bin/env ruby

require 'shellwords'

def dims(image_escaped)
  size_data = `file #{image_escaped}`
  size_data[/, (\d+ x \d+),/, 1].split(' x ').map(&:to_i)
end

def square(image, pad_color='transparent')
  image_esc = Shellwords.escape(image)

  maxdim = dims(image_esc).max
  geometry = "#{maxdim}x#{maxdim}"

  # could use convert if don't want to clobber the image
  system "mogrify -resize #{geometry} -background #{pad_color} -quality 100 -gravity center -extent #{geometry} -format png #{image_esc}"
end

ARGV.each do |image|
  square(image)
end
