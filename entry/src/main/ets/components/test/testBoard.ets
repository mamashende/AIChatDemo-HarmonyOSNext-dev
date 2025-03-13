@ComponentV2
export struct testBoard {
  @Param displayMessage : string = ''
  build() {
    Button(this.displayMessage)
      .fontSize("10");
  }
}