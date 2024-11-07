# encoding: utf-8

require_relative 'test_helper'

class TestFilterParser < Test::Unit::TestCase
  def test_ascii
    assert_kind_of Net::LDAP::Filter, Net::LDAP::Filter::FilterParser.parse("(cn=name)")
  end

  def test_multibyte_characters
    assert_kind_of Net::LDAP::Filter, Net::LDAP::Filter::FilterParser.parse("(cn=名前)")
  end

  def test_brackets
    assert_kind_of Net::LDAP::Filter, Net::LDAP::Filter::FilterParser.parse("(cn=[{something}])")
  end

  def test_slash
    assert_kind_of Net::LDAP::Filter, Net::LDAP::Filter::FilterParser.parse("(departmentNumber=FOO//BAR/FOO)")
  end

  def test_colons
    assert_kind_of Net::LDAP::Filter, Net::LDAP::Filter::FilterParser.parse("(ismemberof=cn=edu:berkeley:app:calmessages:deans,ou=campus groups,dc=berkeley,dc=edu)")
  end

  def test_attr_tag
    assert_kind_of Net::LDAP::Filter, Net::LDAP::Filter::FilterParser.parse("(mail;primary=jane@example.org)")
  end
  
  def test_semicolon_value
    assert_kind_of Net::LDAP::Filter, Net::LDAP::Filter::FilterParser.parse("(mail;primary=jane@example.org;bar)")
  end

  def test_gele_value
    assert_kind_of Net::LDAP::Filter, Net::LDAP::Filter::FilterParser.parse("(mail;primary=jane@example.org<bar>)")
  end

  def test_question_value
    assert_kind_of Net::LDAP::Filter, Net::LDAP::Filter::FilterParser.parse("(mail;primary=jane@example.org?bar)")
  end

  def test_backtick_value
    assert_kind_of Net::LDAP::Filter, Net::LDAP::Filter::FilterParser.parse("(mail;primary=jane@example.org`bar)")
  end

  def test_pipe_value
    assert_kind_of Net::LDAP::Filter, Net::LDAP::Filter::FilterParser.parse("(mail;primary=jane@example.org|bar)")
  end

  def test_dollar_value
    assert_kind_of Net::LDAP::Filter, Net::LDAP::Filter::FilterParser.parse("(mail;primary=jane@example.org$bar)")
  end
end
