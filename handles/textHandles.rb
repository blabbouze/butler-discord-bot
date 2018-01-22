# Contains text handle functions.
#
# It is used to alter the text of a command if needed. e.g. : add string 'zer' to each maymay.
#
# Each function must take 2 arguments :
#   originalText  the user text
#   commandArgs   that will be the extra arguments of a command
#
# First add a function that takes two arguments in the HANDLES::TEXT module. Then
# use it in your maymay.yml config file.
#
# @example Handle function that add 'zer' to each text
#   def addZer(originalText, commandArgs)
#     "#{originalText} zer"
#   end
#
# @example Handle declaration in maymay.yml config file
#     myCommand:
#       asset: 'myAsset'
#       x: 0
#       y: 0
#       textHandle: addZer
#
module HANDLES
  module TEXT
    extend self

    def addZer(originalText, commandArgs)
      "#{originalText} zer"
    end
  end
end