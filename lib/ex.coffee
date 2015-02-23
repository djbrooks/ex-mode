path = require 'path'

class Ex
  quit: ->
    atom.workspace.getActivePane().destroyActiveItem()

  q: =>
    @quit()

  tabedit: (filePaths...) ->
    pane = atom.workspace.getActivePane()
    if filePaths? and filePaths.length > 0
      for file in filePaths
        do -> atom.workspace.openURIInPane file, pane
    else
      atom.workspace.openURIInPane('', pane)

  tabe: (filePaths...) =>
    @tabedit(filePaths...)

  write: (filePath) =>
    projectPath = atom.project.getPath()
    pane = atom.workspace.getActivePane()
    editor = atom.workspace.getActiveEditor()
    if atom.workspace.getActiveTextEditor().getPath() isnt undefined
      if filePath?
        editorPath = editor.getPath()
        editor.saveAs(path.join(projectPath, filePath))
        editor.buffer.setPath(editorPath)
      else
        editor.save()
    else
      if filePath?
        editor.saveAs(path.join(projectPath, filePath))
      else
        pane.saveActiveItemAs()

  w: (filePath) => @write(filePath)

  wa: ->
    atom.workspace.saveAll()

  split: (filePaths...) ->
    pane = atom.workspace.getActivePane()
    if filePaths? and filePaths.length > 0
      newPane = pane.splitUp()
      for file in filePaths
        do ->
          atom.workspace.openURIInPane file, newPane
    else
      pane.splitUp(copyActiveItem: true)

  sp: (filePaths...) => @split(filePaths...)

  vsplit: (filePaths...) ->
    pane = atom.workspace.getActivePane()
    if filePaths? and filePaths.length > 0
      newPane = pane.splitLeft()
      for file in filePaths
        do ->
          atom.workspace.openURIInPane file, newPane
    else
      pane.splitLeft(copyActiveItem: true)

  vsp: (filePaths...) => @vsplit(filePaths...)

module.exports = Ex
