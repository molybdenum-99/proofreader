class Proofreader
  class Exception
    def initialize(postag_regexp:, negate_pos:, postag:, spacebefore:, inflected:, scope:, regexp:, negate:, case_sensitive:)
      @postag_regexp = postag_regexp    # Optional Attribute, Default No
      @negate_pos = negate_pos          # Optional Attribute, Default No
      @postag = postag                  # Optional Attribute
      @spacebefore = spacebefore        # Optional Attribute, Default Ignore (choices: ignore, no, yes)
      @inflected = inflected            # Optional Attribute, Default No
      @scope = scope                    # Optional Attribute, Default Current (choices: current, next, previous)
      @regexp = regexp                  # Optional Attribute, Default No
      @negate = negate                  # Optional Attribute, Default No
      @case_sensitive = case_sensitive  # Optional Attribute
    end

    def self.call(exception_xml)
      return nil if exception_xml.empty?
      
      parsed_exception = from_xml(exception_xml)

      new(postag_regexp: parsed_exception[:postag_regexp], 
          negate_pos: parsed_exception[:negate_pos], 
          postag: parsed_exception[:postag],
          spacebefore: parsed_exception[:spacebefore],
          inflected: parsed_exception[:inflected],
          scope: parsed_exception[:scope],
          regexp: parsed_exception[:regexp],
          negate: parsed_exception[:negate],
          case_sensitive: parsed_exception[:case_sensitive])
    end

    class << self

      private

      def from_xml(exception_xml)
        {
          postag_regexp: exception_xml.attribute('postag_regexp')&.value == 'yes' ? true : false,
          negate_pos: exception_xml.attribute('negate_pos')&.value == 'yes' ? true : false,
          postag: exception_xml.attribute('postag')&.value,
          spacebefore: exception_xml.attribute('spacebefore')&.value ? exception_xml.attribute('spacebefore')&.value : 'ignore', # TODO 2
          inflected: exception_xml.attribute('inflected')&.value == 'yes' ? true : false,
          scope: exception_xml.attribute('scope')&.value ? exception_xml.attribute('scope')&.value : 'current', # TODO 3
          regexp: exception_xml.attribute('regexp')&.value == 'yes' ? true : false,
          negate: exception_xml.attribute('negate')&.value == 'yes' ? true : false,
          case_sensitive: exception_xml.attribute('case_sensitive')&.value
        }
      end
    end
  end
end

# SOURCE: https://github.com/languagetool-org/languagetool/blob/master/languagetool-core/src/main/resources/org/languagetool/rules/pattern.xsd
# TODO 1: Verify that 'yes' ? true: false is a good way of doing this. Master TODO in proofreader file discusses this too.
# TODO 2: How to more elegantly handle ignore?
# TODO 3: How to handle current in default?
# TODO 4: Doesn't specify maxOccur in XML schema. I will need to check in other grammar.xml files