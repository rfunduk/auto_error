namespacedTemplates = ->
  h = {}
  for name, func of window.HandlebarsTemplates
    if name.match( /\// )
      nesting = h
      parts = name.split('/')
      while (part = parts.shift())
        if parts.length == 0
          nesting[part] = func
        else
          nesting[part] ||= {}
          nesting = nesting[part]
    else
      h[name] = func
  h

_.extend( window.AutoErrorApp, {
  Templates: namespacedTemplates()
  Views: {}
} )
