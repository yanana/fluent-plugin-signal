# frozen_string_literal: true

require 'test_helper'
require 'fluent/test/driver/output'

module Fluent
  module Plugin
    class OutSignalTest < Minitest::Test
      CONFIG_1 = %(
        signal_field sig
        pid_field p
      )

      def setup
        Fluent::Test.setup
      end

      def create_driver(conf = CONFIG)
        Fluent::Test::Driver::Output.new(SignalOutput).configure(conf)
      end

      def test_that_it_has_a_version_number
        refute_nil SignalNotification::VERSION
      end

      def test_that_signaling_succeeds
        pid = fork do
          Signal.trap('USR1') do
            Process.kill('KILL', Process.pid)
          end
          sleep(15)
          assert false
        end

        d = create_driver(CONFIG_1)
        puts "pid: #{pid}"

        d.run(default_tag: 't') do
          d.feed('sig' => 'USR1', 'p' => pid)
        end

        Process.waitpid(pid, Process::WNOHANG)
      end
    end
  end
end
