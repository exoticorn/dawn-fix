#!/bin/env ruby
rom = File.open('Dawn.gb', 'rb') {|f| f.read }
ptr = 0x35a4
loop do
  break if rom[ptr].unpack('C')[0] == 0
  count = rom[ptr + 1].unpack('C')[0]
  ptr += 2
  count.times do
    scy = rom[ptr].unpack('C')[0]
    rom[ptr] = [scy - 1].pack('C')
    ptr += 2
  end
end
checksum = 0
rom.size.times do |i|
  if i != 0x14e && i != 0x14f
    checksum += rom[i].unpack('C')[0]
  end
end
rom[0x14e, 2] = [checksum].pack('n')
File.open('Dawn_fixed.gb', 'wb') {|f| f.write(rom) }
