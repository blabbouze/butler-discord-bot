require_relative '../handles/textHandles.rb'

# Model of a maymay
# Once initialized, call generate(text) to generate the maymay with given text.
class Maymay

  # Name of the folder that will contains maymay with generated text
  # If you change this please update .gitignore to not push generated maymay into git.
  MAYMAY_OUT_FOLDER = 'out'

  # Constructor
  #
  # @param [Hash] args maymay options
  #
  # @option args [String]  :asset       [Required] Base maymay image (must be in asset folder)
  # @option args [int]     :x           [Optional] X coordinate of the drawn text (default = 0)
  # @option args [int]     :y           [Optional] Y coordinate of the drawn text (default = 0)
  # @option args [String]  :textColor   [Optional] Color of the drawn text. Format rrggbb (default = 'ffffff'). # will be prepended automaticall.
  # @option args [String]  :textHandle  [Optional] Text handle (see handles folder for more informations about handles)
  def initialize(args)
    @asset = args['asset']

    @x_txt_coord = args['x']
    @x_txt_coord = 0 if @x_txt_coord.nil?

    @y_txt_coord = args['y']
    @y_txt_coord = 0 if @y_txt_coord.nil?

    @text_handle = args['textHandle']

    @text_color = args['textColor']
    @text_color = '#ffffff' if @text_color.nil?
  end

  
  #
  # Generate current maymay
  #
  # @param text  [string] Text to print on the maymay
  #
  # @return output_file_path [string] Path to the generated maymay
  def generate(text)
    # Call text handle to modify text if necessary
    text = HANDLES::TEXT.send(@text_handle, text, '') if @text_handle

    # Format message
    message = format_text(text, 22).join('\n')

    # Create output directory if it doesn't exists
    Dir.mkdir(MAYMAY_OUT_FOLDER) unless Dir.exists?(MAYMAY_OUT_FOLDER)
    # Compute output file
    output_file_path = "#{MAYMAY_OUT_FOLDER}/#{@asset}"

    # Create maymay with given arguments
    args = {
      input: "assets/#{@asset}",
      output: output_file_path,
      color: @text_color,
      x: @x_txt_coord,
      y: @y_txt_coord,
      text: message
    }
    execute_gm(args)

    # Send back path to the maymay
    return output_file_path
  end

  # Split given text with carriage return if the line exceed given size.
  #
  # @param str  [string]  string to format
  # @param size [int]     maximum size for one line
  #
  # @return [Array<string>] each array field represent a line
  #
  def format_text(str, size)
    if str.size > size
      trimmed_str = str[0..size]
      idx = trimmed_str.rindex(' ')

      [].concat([trimmed_str[0..[trimmed_str.size, idx].min],
                 format_text(str[(idx + 1)...str.size], size)])
    else
      [str]
    end
  end
  private :format_text

  # Execute gm with given args
  #
  # @param [Hash] args arguments passed to gm command.
  #
  # @option args [String] :input   Input file to convert
  # @option args [String] :output  Result file
  # @option args [String] :color   Color of the text
  # @option args [int]    :x       X coordinates of the text
  # @option args [int]    :y       Y coordinates of the text
  # @option args [String] :text    Text to draw in the picture
  def execute_gm(args)
    cmd = ["gm convert",
           args[:input],
           '-stroke \#000000',
           "-fill \##{args[:color]}",
           '-font "assets/impact-opt.ttf"',
           '-pointsize 50',
           "-draw \"text #{args[:x]},#{args[:y]} '#{args[:text]}'\"",
           '-gravity Center',
           '-quality 100',
           args[:output]
           ].join(' ')

    puts "Executed command : #{cmd}"
    system(cmd)
  end
  private :execute_gm

end