# Contains asset handle functions.
#
# It is used to alter the assets of a command if needed. e.g. : randomize asset.
#
# Each function must take 2 arguments :
#   originalAsset  the original asset
#   commandArgs    that will be the extra arguments of a command
#
# First add a function that takes two arguments in the HANDLES::ASSET module. Then
# use it in your maymay.yml config file.
#
# @example Handle function that take an random asset
#   def addZer(originalText, commandArgs)
#     "#{originalText} zer"
#   end
#
# @example Handle declaration in maymay.yml config file
#     myCommand:
#       assetHandle: randomize
#       x: 0
#       y: 0
#
module HANDLES
    module ASSET
        extend self

        def randomize(originalAsset,commandArgs)
            Dir.entries("assets").reject {|f| File.directory?(f) || File.extname(f) == '.ttf' }.sample
        end
    end
end