require_relative '../PasswordHash.rb'

module Test

  def self.runTests
    truncatedHashTest()
    testHashFunctionChecking()
  end

  def self.truncatedHashTest
    userString = "awesomeBooks!"
    hash = PasswordHash.createHash( userString )
    badHashLength = hash.length
    badResult = false

    loop do
      badHashLength -= 1
      badHash = hash[0...badHashLength]
      badResult = PasswordHash.validatePassword( userString, badHash )

      if badResult != false
        puts "Truncated hash test: FAIL (At hash length of #{badHashLength})"
        exit(1)
      end
     break if badHash[ badHashLength - 3, 1] == ':'
    end

    puts "Truncated hash test: pass" if badResult == false
  end

  def self.testHashFunctionChecking
    hash = PasswordHash.createHash("foobar")
    hash = hash.sub("sha1:", "sha256:")
    if PasswordHash.validatePassword("foobar", hash) == false
      puts "Algorithm swap: pass"
    else
      puts "Algorithm swap: FAIL"
      exit(1)
    end
  end

end

Test.runTests()
