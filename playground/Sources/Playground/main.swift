//
//  main.swift
//  documenter
//
//  Created by Marcin Krzyzanowski on 17/07/2018.
//  Copyright © 2018 Marcin Krzyzanowski. All rights reserved.
//

import Foundation
import Antlr4
import SwiftParser

class TestListener: SwiftBaseListener {
    override func enterStatement(_ ctx: SwiftParser.StatementContext) {
        let content = ctx.getText()
        print("Statement: \(content)")
    }
}

do {
    let sourceFilePath = FileManager.default.currentDirectoryPath + "/starwars.schema"
    let url = URL.init(fileURLWithPath: sourceFilePath)
    let data = try Data(contentsOf: url)

    let input = try ANTLRFileStream(sourceFilePath, String.Encoding.utf8)
    let lexer = GraphQLLexer(input)
    let tokens = CommonTokenStream(lexer)
    let parser = try SwiftParser(tokens)
    let tree = try parser.topLevel()

    let walker = ParseTreeWalker()
    let extractor = TestListener.init()
    try walker.walk(extractor, tree)
    print("done")
} catch {
    print("Error \(error)")
}




