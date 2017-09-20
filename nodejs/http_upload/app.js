let fs      = require('fs');
let express = require('express');
let app     = express();


fs.exists('./uploads', function(exists) {
    if (!exists) {
        fs.mkdirSync('./uploads');
    }
})

//文件上传服务
app.post('/upload', function (req, res, next) {
    console.log(req.query)

    let dirname  = req.query.dirname;
    let filename = req.query.filename;
    let type     = req.query.type;
    let ishead   = req.query.ishead;
    let text     = req.query.text;

    let dirpath = './uploads/' + dirname;
    let filepath = dirpath + "/" + filename;

    // 新文件
    if (ishead == 1) {
        let exists = fs.existsSync(dirpath);
        if (!exists) {
            fs.mkdirSync(dirpath);
        }
    }

    fs.appendFileSync(filepath, text)


    res.send("success")
});

app.get("/", function(req, res) {
    res.send("ok")
})

app.listen(3000)
