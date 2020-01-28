# frozen_string_literal: true

require 'fluent/plugin/output'
require 'fluent/plugin/signal/version'

module Fluent
  module Plugin
    # Signal notifies another process using POSIX signals.
    class SignalOutput < Output
      Plugin.register_output('signal', self)

      helpers :event_emitter

      config_param :signal_field, :string, default: :signal
      config_param :pid_field, :string, default: :pid

      def initialize
        super
      end

      def configure(conf)
        super
      end

      def multi_workers_ready?
        true
      end

      def process(tag, es)
        es.each do |time, record|
          signal = record[@signal_field]
          pid = record[@pid_field]
          puts "signal: #{signal}, pid: #{pid}"
          Process.kill(signal, pid)
        end
      end
    end
  end
end
