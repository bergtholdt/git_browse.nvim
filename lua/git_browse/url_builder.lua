local M = {}

M.build_github_url = function(repo, branch_name, path)
  if path then
    return "https://github.com/" .. repo .. "/blob/" .. branch_name .. "/" .. path
  else
    return "https://github.com/" .. repo .. "/tree/" .. branch_name
  end
end

M.build_gitlab_url = function(domain, repo, branch, path)
  return "TODO" -- noop for now
end

M.build_url = function(remote, current_branch_name, path_in_repo)
  local _, _, domain, repo = string.find(remote, "[htps:/@]+(.*)[/:](%a+/.+)%p.*")

  if domain and repo then
    if string.find(domain, "github.com") then
      return M.build_github_url(repo, current_branch_name, path_in_repo)
    else
      return M.build_gitlab_url(domain, repo, current_branch_name, path_in_repo)
    end
  else
    -- TODO: throw exception
    return { status = "error parsing remote " .. remote }
  end
end

return M