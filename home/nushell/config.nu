$env.config = {
  hooks: {
    pre_prompt: [{ ||
      if (which direnv | is-empty) {
        return
      }

      direnv export json | from json | default {} | load-env
    }]
  }
}

$env.EDITOR = 'nvim';
$env.KUBE_EDITOR = 'nvim';

#$env.ASDF_DIR = '/Users/cbartelt/.asdf'
#source /Users/cbartelt/.asdf/asdf.nu
