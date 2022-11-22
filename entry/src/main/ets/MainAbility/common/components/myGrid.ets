@Component
struct MyGrid{
    @Link btnList:number[]
    build(){
        Column() {
            Grid() {
                ForEach(this.btnList, (item, index) => {
                    if (index == 0) {
                        GridItem() {
                            Button("按钮" + item)
                                .width("100%")
                                .height("100%")
                                .type(ButtonType.Normal)
                                .borderRadius(5)
                        }
                        .columnStart(0)
                        .columnEnd(1)
                        .rowStart(0)
                        .rowEnd(1)
                    }
                    if (index > 0 && index < 3) {
                        GridItem() {
                            Button("按钮" + item)
                                .width("100%")
                                .height("100%")
                                .type(ButtonType.Normal)
                                .borderRadius(5)
                        }
                    }
                    if (index == 3) {
                        GridItem() {
                            Button("按钮" + item)
                                .width("100%")
                                .height("100%")
                                .type(ButtonType.Normal)
                                .borderRadius(5)
                        }
                        .columnStart(2)
                        .columnEnd(3)
                    }
                    if (index > 3) {
                        GridItem() {
                            Button("按钮" + item)
                                .width("100%")
                                .height("100%")
                                .type(ButtonType.Normal)
                                .borderRadius(5)
                        }

                    }
                })
            }
            .width("100%")
            .height("200")
            .columnsTemplate("1fr 1fr 1fr 1fr")
            .rowsTemplate("1fr 1fr 1fr")
            .rowsGap(5)
            .columnsGap(5)
            .border({ width: 1, color: "000" })
        }
        .padding(10)
    }
}

export default MyGrid