class Net::LDAP
  class LdapError < StandardError
    def message
      "Deprecation warning: Net::LDAP::LdapError is no longer used. Use Net::LDAP::Error or rescue one of it's subclasses. \n" + super
    end
  end

  module Error; end
  class ErrorClass < StandardError;
    include Error
  end
  class AlreadyOpenedError < ErrorClass; end
  class SocketError < ErrorClass; end
  class ConnectionRefusedError < Errno::ECONNREFUSED
    include Error
    def self.===(val)
      warn_deprecation_message
      super
    end

    def initialize(*args)
      # warn_deprecation_message
      super
    end

    def self.warn_deprecation_message
      warn "Deprecation warning: Net::LDAP::ConnectionRefused will be deprecated. Use Errno::ECONNREFUSED instead."
    end
  end

  class ConnectionError < ErrorClass
    def self.new(errors)
      error = errors.first.first
      if errors.size == 1
        if error.kind_of? Errno::ECONNREFUSED
          return Net::LDAP::ConnectionRefusedError.new(error.message)
        end

        return Net::LDAP::ErrorClass.new(error.message)
      end

      super
    end

    def initialize(errors)
      message = "Unable to connect to any given server: \n  #{errors.map { |e, h, p| "#{e.class}: #{e.message} (#{h}:#{p})" }.join("\n  ")}"
      super(message)
    end
  end
  class NoOpenSSLError < ErrorClass; end
  class NoStartTLSResultError < ErrorClass; end
  class NoSearchBaseError < ErrorClass; end
  class StartTLSError < ErrorClass; end
  class EncryptionUnsupportedError < ErrorClass; end
  class EncMethodUnsupportedError < ErrorClass; end
  class AuthMethodUnsupportedError < ErrorClass; end
  class BindingInformationInvalidError < ErrorClass; end
  class NoBindResultError < ErrorClass; end
  class SASLChallengeOverflowError < ErrorClass; end
  class SearchSizeInvalidError < ErrorClass; end
  class SearchScopeInvalidError < ErrorClass; end
  class ResponseTypeInvalidError < ErrorClass; end
  class ResponseMissingOrInvalidError < ErrorClass; end
  class EmptyDNError < ErrorClass; end
  class InvalidDNError < ErrorClass; end
  class HashTypeUnsupportedError < ErrorClass; end
  class OperatorError < ErrorClass; end
  class SubstringFilterError < ErrorClass; end
  class SearchFilterError < ErrorClass; end
  class BERInvalidError < ErrorClass; end
  class SearchFilterTypeUnknownError < ErrorClass; end
  class BadAttributeError < ErrorClass; end
  class FilterTypeUnknownError < ErrorClass; end
  class FilterSyntaxInvalidError < ErrorClass; end
  class EntryOverflowError < ErrorClass; end
end
