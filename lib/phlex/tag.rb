# frozen_string_literal: true

module Phlex
  class Tag
    DASH = "-"
    SPACE = " "
    UNDERSCORE = "_"
    NAMESPACE_DELINEATOR = "::"

    class Area < VoidElement; end
    class Embed < VoidElement; end
    class Img < VoidElement; end
    class Input < VoidElement; end
    class Link < VoidElement; end
    class Meta < VoidElement; end
    class Param < VoidElement; end
    class Track < VoidElement; end
    class Col < VoidElement; end

    class A < StandardElement; end
    class Abbr < StandardElement; end
    class Address < StandardElement; end
    class Article < StandardElement; end
    class Aside < StandardElement; end
    class B < StandardElement; end
    class Bdi < StandardElement; end
    class Bdo < StandardElement; end
    class Blockquote < StandardElement; end
    class Body < StandardElement; end
    class Button < StandardElement; end
    class Caption < StandardElement; end
    class Cite < StandardElement; end
    class Code < StandardElement; end
    class Colgroup < StandardElement; end
    class Data < StandardElement; end
    class Datalist < StandardElement; end
    class Dd < StandardElement; end
    class Del < StandardElement; end
    class Details < StandardElement; end
    class Dfn < StandardElement; end
    class Dialog < StandardElement; end
    class Div < StandardElement; end
    class Dl < StandardElement; end
    class Dt < StandardElement; end
    class Em < StandardElement; end
    class Fieldset < StandardElement; end
    class Figcaption < StandardElement; end
    class Figure < StandardElement; end
    class Footer < StandardElement; end
    class Form < StandardElement; end
    class H1 < StandardElement; end
    class H2 < StandardElement; end
    class H3 < StandardElement; end
    class H4 < StandardElement; end
    class H5 < StandardElement; end
    class H6 < StandardElement; end
    class Head < StandardElement; end
    class Header < StandardElement; end
    class Html < StandardElement; end
    class I < StandardElement; end
    class Iframe < StandardElement; end
    class Ins < StandardElement; end
    class Kbd < StandardElement; end
    class Label < StandardElement; end
    class Legend < StandardElement; end
    class Li < StandardElement; end
    class Main < StandardElement; end
    class Map < StandardElement; end
    class Mark < StandardElement; end
    class Menuitem < StandardElement; end
    class Meter < StandardElement; end
    class Nav < StandardElement; end
    class Noscript < StandardElement; end
    class Object < StandardElement; end
    class Ol < StandardElement; end
    class Optgroup < StandardElement; end
    class Option < StandardElement; end
    class Output < StandardElement; end
    class P < StandardElement; end
    class Picture < StandardElement; end
    class Pre < StandardElement; end
    class Progress < StandardElement; end
    class Q < StandardElement; end
    class Rp < StandardElement; end
    class Rt < StandardElement; end
    class Ruby < StandardElement; end
    class S < StandardElement; end
    class Samp < StandardElement; end
    class Script < StandardElement; end
    class Section < StandardElement; end
    class Select < StandardElement; end
    class Slot < StandardElement; end
    class Small < StandardElement; end
    class Span < StandardElement; end
    class Strong < StandardElement; end
    class Sub < StandardElement; end
    class Summary < StandardElement; end
    class Sup < StandardElement; end
    class Table < StandardElement; end
    class Tbody < StandardElement; end
    class Td < StandardElement; end
    class Template < StandardElement; end
    class Textarea < StandardElement; end
    class Tfoot < StandardElement; end
    class Th < StandardElement; end
    class Thead < StandardElement; end
    class Time < StandardElement; end
    class Title < StandardElement; end
    class Tr < StandardElement; end
    class U < StandardElement; end
    class Ul < StandardElement; end
    class Video < StandardElement; end
    class Wbr < StandardElement; end

    class << self
      def tag_name
        @tag_name ||= name.split(NAMESPACE_DELINEATOR).last.downcase
      end
    end

    def initialize(**attributes)
      @classes = String.new
      self.attributes = attributes
    end

    def attributes=(attributes)
      self.classes = attributes.delete(:class)
      @attributes = attributes
    end

    def classes=(value)
      case value
      when String
        @classes << value.prepend(SPACE)
      when Symbol
        @classes << value.to_s.prepend(SPACE)
      when Array
        @classes << value.join(SPACE).prepend(SPACE)
      when nil
        return
      else
        raise ArgumentError, "Classes must be String, Symbol, or Array<String>."
      end
    end

    private

    def opening_tag_content
      self.class.tag_name + attributes
    end

    def attributes
      attributes = @attributes.dup
      attributes[:class] = classes
      attributes.compact!
      attributes.transform_values! { ERB::Util.html_escape(_1) }
      attributes = attributes.map { |k, v| %Q(#{k}="#{v}") }.join(SPACE)
      attributes.prepend(SPACE) unless attributes.empty?
      attributes
    end

    def classes
      return if @classes.empty?
      @classes.gsub!(UNDERSCORE, DASH)
      @classes.strip!
      @classes
    end
  end
end
