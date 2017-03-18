class Paginator

    private
    attr_reader :current_page, :per_page, :list

    public
    def initialize(list)
        @current_page = 1
        @per_page     = 3
        @list         = list.freeze
    end

    def paginate(&block)
        begin_index = (current_page - 1) * per_page
        end_index   = (current_page * per_page) - 1

        paginated_list = list.slice(begin_index..end_index)

        paginated_list.each do |object|
            block.(object) if block_given?
        end

        ask_action(&block)
    end

    private
    def ask_action(&block)
        return if total_pages <= 1

        puts "\n#{current_page} of #{total_pages}"

        puts "\nPrevious(p) Next(n) Quit(q):"
        print "> "
        option = STDIN.gets.strip

        return        if (/^q/.match(option))
        next_page     if (/^n/.match(option))
        previous_page if (/^p/.match(option))

        paginate(&block)
    end

    def next_page
        @current_page += 1
    end

    def previous_page
        @current_page -= 1
    end

    def total_pages
        list.size / per_page
    end

end
