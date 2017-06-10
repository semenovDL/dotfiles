require 'yaml'
require 'fileutils'

class Repo
  attr_reader :path
  def initialize(gh:, path:, organization:)
    @github_repo =
      case gh.split('/').size
      when 1
        File.join(organization, gh)
      when 2
        gh
      else
        raise "Unsupported gh: #{gh}"
      end
    @path = path || gh.split('/').last
  end

  def clone
    return if Dir.exist?(@path)
    puts "> clone #{@github_repo} into #{File.expand_path(@path)}"
    `git clone git@github.com:#{@github_repo}.git #{@path}`
  end

  def pull
    puts "> pull #{File.expand_path(@path)}"
    Dir.chdir(@path) { `git pull` }
  end
end

class Node
  attr_reader :path, :organization, :update
  def initialize(path:, organization:, update:, repos:)
    @path = path
    @organization = organization
    @update = update
    @repos = repos.map do |repo|
      Repo.new(
        gh: repo['gh'],
        path: repo['path'],
        organization: organization
      )
    end
  end

  def clone_all
    FileUtils.mkdir_p(path)
    Dir.chdir(path) { @repos.each(&:clone) }
  end

  def pull_all
    @update && Dir.chdir(path) { @repos.each(&:pull) }
  end

  class << self
    def register_root(path)
      @root = new(
        path: path.sub('~', ENV['HOME']),
        organization: nil,
        update: false,
        repos: []
      )
    end

    def tree
      @tree ||= {}
    end

    def register(data)
      path = data['path']
      parent = find_parent(path)
      raise "Node #{path} already registered" if tree.key?(path)
      tree[path] = new(
        path: File.join(@root.path, path),
        organization: data.fetch('organization', parent.organization),
        update: data.fetch('update', parent.update),
        repos: data.fetch('repos', [])
      )
    end

    def find_parent(path)
      parent_path = path.split('/')[0..-2].join('/')
      return @root if parent_path.empty?
      tree[parent_path] ||= register('path' => parent_path)
    end

    def clone_all
      tree.each_value(&:clone_all)
    end

    def pull_all
      tree.each_value(&:pull_all)
    end
  end
end

config = YAML.load_file(File.join(File.dirname(__FILE__), 'repositories.yml'))

Node.register_root(config['root_path'])
config['nodes'].sort_by { |n| n['path'] }.each { |n| Node.register(n) }
