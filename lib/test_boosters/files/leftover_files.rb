module TestBoosters
  module Files
    class LeftoverFiles

      attr_reader :files

      def initialize(files)
        @files = files
      end

      def select(options = {})
        index = options.fetch(:index)
        total = options.fetch(:total)

        file_distribution(total)[index]
      end

      private

      def file_distribution(job_count)
        # create N empty boxes
        jobs = Array.new(job_count) { [] }

        # distribute files in Round Robin fashion
        existing_files.each.with_index do |file, index|
          jobs[index % job_count] << file
        end

        jobs
      end

      def existing_files
        @existing_files ||= @files.select { |file| File.file?(file) }
      end

    end
  end
end
