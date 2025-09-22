//
//  DataManager.swift
//  doublesChinese
//
//  Created by Wu, Fei on 9/15/25.
//

import Foundation

class DataManager: ObservableObject {
    @Published var lessons: [Lesson] = []
    @Published var allCharacters: [ChineseCharacter] = []
    
    init() {
        loadSampleData()
        // Print lesson IDs for debugging
        print("DataManager initialized with lessons:")
        lessons.forEach { lesson in
            print("Lesson \(lesson.bookNumber)-\(lesson.lessonNumber) ID: \(lesson.id)")
        }
    }
    
    private func loadSampleData() {
        // Sample data organized by books and lessons
        let sampleLessons = [
            // Book 1
            Lesson(
                bookNumber: 1,
                lessonNumber: 1,
                title: "Basic Numbers",
                characters: [
                    ChineseCharacter(character: "一", pinyin: "yī", meaning: "one", exampleWords: ["一个 (yī gè) - one piece", "一天 (yī tiān) - one day"], bookNumber: 1, lessonNumber: 1),
                    ChineseCharacter(character: "二", pinyin: "èr", meaning: "two", exampleWords: ["二手 (èr shǒu) - second-hand", "二月 (èr yuè) - February"], bookNumber: 1, lessonNumber: 1),
                    ChineseCharacter(character: "三", pinyin: "sān", meaning: "three", exampleWords: ["三个 (sān gè) - three pieces", "三月 (sān yuè) - March"], bookNumber: 1, lessonNumber: 1),
                    ChineseCharacter(character: "四", pinyin: "sì", meaning: "four", exampleWords: ["四个 (sì gè) - four pieces", "四月 (sì yuè) - April"], bookNumber: 1, lessonNumber: 1),
                    ChineseCharacter(character: "五", pinyin: "wǔ", meaning: "five", exampleWords: ["五个 (wǔ gè) - five pieces", "五月 (wǔ yuè) - May"], bookNumber: 1, lessonNumber: 1)
                ]
            ),
            Lesson(
                bookNumber: 1,
                lessonNumber: 2,
                title: "Family Members",
                characters: [
                    ChineseCharacter(character: "爸", pinyin: "bà", meaning: "dad", exampleWords: ["爸爸 (bà ba) - dad", "爸妈 (bà mā) - parents"], bookNumber: 1, lessonNumber: 2),
                    ChineseCharacter(character: "妈", pinyin: "mā", meaning: "mom", exampleWords: ["妈妈 (mā ma) - mom", "奶奶 (nǎi nai) - grandma"], bookNumber: 1, lessonNumber: 2),
                    ChineseCharacter(character: "我", pinyin: "wǒ", meaning: "I/me", exampleWords: ["我们 (wǒ men) - we", "我的 (wǒ de) - my"], bookNumber: 1, lessonNumber: 2),
                    ChineseCharacter(character: "你", pinyin: "nǐ", meaning: "you", exampleWords: ["你好 (nǐ hǎo) - hello", "你们 (nǐ men) - you all"], bookNumber: 1, lessonNumber: 2),
                    ChineseCharacter(character: "他", pinyin: "tā", meaning: "he/him", exampleWords: ["他们 (tā men) - they", "他的 (tā de) - his"], bookNumber: 1, lessonNumber: 2)
                ]
            ),
            
            // Book 2
            Lesson(
                bookNumber: 2.1,
                lessonNumber: 1,
                title: "School and Life",
                characters: [
                    ChineseCharacter(character: "生", pinyin: "shēng", meaning: "birth/life", exampleWords: ["学生 (xué shēng) - student", "生活 (shēng huó) - life"], bookNumber: 2.1, lessonNumber: 1),
                    ChineseCharacter(character: "刀", pinyin: "dāo", meaning: "knife", exampleWords: ["小刀 (xiǎo dāo) - small knife", "刀子 (dāo zi) - knife"], bookNumber: 2.1, lessonNumber: 1),
                    ChineseCharacter(character: "这", pinyin: "zhè", meaning: "this", exampleWords: ["这个 (zhè gè) - this one", "这里 (zhè lǐ) - here"], bookNumber: 2.1, lessonNumber: 1),
                    ChineseCharacter(character: "笔", pinyin: "bǐ", meaning: "pen", exampleWords: ["铅笔 (qiān bǐ) - pencil", "毛笔 (máo bǐ) - brush pen"], bookNumber: 2.1, lessonNumber: 1),
                    ChineseCharacter(character: "那", pinyin: "nà", meaning: "that", exampleWords: ["那个 (nà gè) - that one", "那里 (nà lǐ) - there"], bookNumber: 2.1, lessonNumber: 1),
                    ChineseCharacter(character: "本", pinyin: "běn", meaning: "book/origin", exampleWords: ["课本 (kè běn) - textbook", "本来 (běn lái) - originally"], bookNumber: 2.1, lessonNumber: 1),
                    ChineseCharacter(character: "老", pinyin: "lǎo", meaning: "old", exampleWords: ["老师 (lǎo shī) - teacher", "老人 (lǎo rén) - elderly person"], bookNumber: 2.1, lessonNumber: 1),
                    ChineseCharacter(character: "习", pinyin: "xí", meaning: "practice", exampleWords: ["学习 (xué xí) - study", "习惯 (xí guàn) - habit"], bookNumber: 2.1, lessonNumber: 1)
                ]
            ),
            Lesson(
                bookNumber: 2.1,
                lessonNumber: 2,
                title: "Daily Activities",
                characters: [
                    ChineseCharacter(character: "课", pinyin: "kè", meaning: "class/lesson", exampleWords: ["上课 (shàng kè) - attend class", "课本 (kè běn) - textbook"], bookNumber: 2.1, lessonNumber: 2),
                    ChineseCharacter(character: "快", pinyin: "kuài", meaning: "fast/quick", exampleWords: ["快点 (kuài diǎn) - hurry up", "很快 (hěn kuài) - very fast"], bookNumber: 2.1, lessonNumber: 2),
                    ChineseCharacter(character: "用", pinyin: "yòng", meaning: "use", exampleWords: ["使用 (shǐ yòng) - to use", "有用 (yǒu yòng) - useful"], bookNumber: 2.1, lessonNumber: 2),
                    ChineseCharacter(character: "猪", pinyin: "zhū", meaning: "pig", exampleWords: ["小猪 (xiǎo zhū) - piglet", "猪肉 (zhū ròu) - pork"], bookNumber: 2.1, lessonNumber: 2),
                    ChineseCharacter(character: "再", pinyin: "zài", meaning: "again", exampleWords: ["再见 (zài jiàn) - goodbye", "再来 (zài lái) - come again"], bookNumber: 2.1, lessonNumber: 2),
                    ChineseCharacter(character: "见", pinyin: "jiàn", meaning: "see/meet", exampleWords: ["再见 (zài jiàn) - goodbye", "见面 (jiàn miàn) - meet"], bookNumber: 2.1, lessonNumber: 2)
                ]
            ),
            Lesson(
                bookNumber: 2.1,
                lessonNumber: 3,
                title: "School Places",
                characters: [
                    ChineseCharacter(character: "校", pinyin: "xiào", meaning: "school", exampleWords: ["学校 (xué xiào) - school", "校长 (xiào zhǎng) - principal"], bookNumber: 2.1, lessonNumber: 3),
                    ChineseCharacter(character: "师", pinyin: "shī", meaning: "teacher", exampleWords: ["老师 (lǎo shī) - teacher", "师父 (shī fu) - master"], bookNumber: 2.1, lessonNumber: 3),
                    ChineseCharacter(character: "教", pinyin: "jiào", meaning: "teach", exampleWords: ["教书 (jiào shū) - teach", "教室 (jiào shì) - classroom"], bookNumber: 2.1, lessonNumber: 3),
                    ChineseCharacter(character: "室", pinyin: "shì", meaning: "room", exampleWords: ["教室 (jiào shì) - classroom", "办公室 (bàn gōng shì) - office"], bookNumber: 2.1, lessonNumber: 3),
                    ChineseCharacter(character: "写", pinyin: "xiě", meaning: "write", exampleWords: ["写字 (xiě zì) - write characters", "写作 (xiě zuò) - writing"], bookNumber: 2.1, lessonNumber: 3),
                    ChineseCharacter(character: "字", pinyin: "zì", meaning: "character/word", exampleWords: ["汉字 (hàn zì) - Chinese character", "写字 (xiě zì) - write"], bookNumber: 2.1, lessonNumber: 3)
                ]
            ),
            Lesson(
                bookNumber: 2.1,
                lessonNumber: 4,
                title: "Animals and Actions",
                characters: [
                    ChineseCharacter(character: "猫", pinyin: "māo", meaning: "cat", exampleWords: ["小猫 (xiǎo māo) - kitten", "猫咪 (māo mī) - kitty"], bookNumber: 2.1, lessonNumber: 4),
                    ChineseCharacter(character: "吃", pinyin: "chī", meaning: "eat", exampleWords: ["吃饭 (chī fàn) - eat meal", "吃东西 (chī dōng xi) - eat things"], bookNumber: 2.1, lessonNumber: 4),
                    ChineseCharacter(character: "谢", pinyin: "xiè", meaning: "thank", exampleWords: ["谢谢 (xiè xie) - thank you", "感谢 (gǎn xiè) - grateful"], bookNumber: 2.1, lessonNumber: 4),
                    ChineseCharacter(character: "不", pinyin: "bù", meaning: "not", exampleWords: ["不是 (bù shì) - is not", "不好 (bù hǎo) - not good"], bookNumber: 2.1, lessonNumber: 4),
                    ChineseCharacter(character: "骨", pinyin: "gǔ", meaning: "bone", exampleWords: ["骨头 (gǔ tou) - bone", "骨骼 (gǔ gé) - skeleton"], bookNumber: 2.1, lessonNumber: 4),
                    ChineseCharacter(character: "同", pinyin: "tóng", meaning: "same/together", exampleWords: ["同学 (tóng xué) - classmate", "相同 (xiāng tóng) - same"], bookNumber: 2.1, lessonNumber: 4)
                ]
            ),
            Lesson(
                bookNumber: 2.1,
                lessonNumber: 5,
                title: "Time and Objects",
                characters: [
                    ChineseCharacter(character: "种", pinyin: "zhǒng", meaning: "kind/type", exampleWords: ["种类 (zhǒng lèi) - type", "各种 (gè zhǒng) - various"], bookNumber: 2.1, lessonNumber: 5),
                    ChineseCharacter(character: "瓜", pinyin: "guā", meaning: "melon", exampleWords: ["西瓜 (xī guā) - watermelon", "冬瓜 (dōng guā) - winter melon"], bookNumber: 2.1, lessonNumber: 5),
                    ChineseCharacter(character: "收", pinyin: "shōu", meaning: "collect/receive", exampleWords: ["收到 (shōu dào) - receive", "收拾 (shōu shi) - tidy up"], bookNumber: 2.1, lessonNumber: 5),
                    ChineseCharacter(character: "很", pinyin: "hěn", meaning: "very", exampleWords: ["很好 (hěn hǎo) - very good", "很多 (hěn duō) - very many"], bookNumber: 2.1, lessonNumber: 5),
                    ChineseCharacter(character: "豆", pinyin: "dòu", meaning: "bean", exampleWords: ["豆子 (dòu zi) - beans", "红豆 (hóng dòu) - red beans"], bookNumber: 2.1, lessonNumber: 5),
                    ChineseCharacter(character: "它", pinyin: "tā", meaning: "it", exampleWords: ["它们 (tā men) - they (things)", "它是 (tā shì) - it is"], bookNumber: 2.1, lessonNumber: 5),
                    ChineseCharacter(character: "想", pinyin: "xiǎng", meaning: "think/want", exampleWords: ["想要 (xiǎng yào) - want", "思想 (sī xiǎng) - thought"], bookNumber: 2.1, lessonNumber: 5)
                ]
            ),
            Lesson(
                bookNumber: 2.1,
                lessonNumber: 6,
                title: "Seasons and Colors",
                characters: [
                    ChineseCharacter(character: "季", pinyin: "jì", meaning: "season", exampleWords: ["四季 (sì jì) - four seasons", "季节 (jì jié) - season"], bookNumber: 2.1, lessonNumber: 6),
                    ChineseCharacter(character: "夏", pinyin: "xià", meaning: "summer", exampleWords: ["夏天 (xià tiān) - summer", "夏季 (xià jì) - summer season"], bookNumber: 2.1, lessonNumber: 6),
                    ChineseCharacter(character: "秋", pinyin: "qiū", meaning: "autumn", exampleWords: ["秋天 (qiū tiān) - autumn", "秋季 (qiū jì) - autumn season"], bookNumber: 2.1, lessonNumber: 6),
                    ChineseCharacter(character: "冬", pinyin: "dōng", meaning: "winter", exampleWords: ["冬天 (dōng tiān) - winter", "冬季 (dōng jì) - winter season"], bookNumber: 2.1, lessonNumber: 6),
                    ChineseCharacter(character: "换", pinyin: "huàn", meaning: "change/exchange", exampleWords: ["换衣服 (huàn yī fu) - change clothes", "交换 (jiāo huàn) - exchange"], bookNumber: 2.1, lessonNumber: 6),
                    ChineseCharacter(character: "衣", pinyin: "yī", meaning: "clothes", exampleWords: ["衣服 (yī fu) - clothes", "毛衣 (máo yī) - sweater"], bookNumber: 2.1, lessonNumber: 6),
                    ChineseCharacter(character: "服", pinyin: "fú", meaning: "clothes", exampleWords: ["衣服 (yī fu) - clothes", "校服 (xiào fú) - school uniform"], bookNumber: 2.1, lessonNumber: 6),
                    ChineseCharacter(character: "年", pinyin: "nián", meaning: "year", exampleWords: ["今年 (jīn nián) - this year", "新年 (xīn nián) - new year"], bookNumber: 2.1, lessonNumber: 6),
                    ChineseCharacter(character: "绿", pinyin: "lǜ", meaning: "green", exampleWords: ["绿色 (lǜ sè) - green color", "绿叶 (lǜ yè) - green leaves"], bookNumber: 2.1, lessonNumber: 6),
                    ChineseCharacter(character: "红", pinyin: "hóng", meaning: "red", exampleWords: ["红色 (hóng sè) - red color", "红花 (hóng huā) - red flower"], bookNumber: 2.1, lessonNumber: 6)
                ]
            ),
            Lesson(
                bookNumber: 2.1,
                lessonNumber: 7,
                title: "People and Things",
                characters: [
                    ChineseCharacter(character: "名", pinyin: "míng", meaning: "name", exampleWords: ["姓名 (xìng míng) - full name", "名字 (míng zi) - name"], bookNumber: 2.1, lessonNumber: 7),
                    ChineseCharacter(character: "时", pinyin: "shí", meaning: "time", exampleWords: ["时间 (shí jiān) - time", "有时 (yǒu shí) - sometimes"], bookNumber: 2.1, lessonNumber: 7),
                    ChineseCharacter(character: "候", pinyin: "hòu", meaning: "time/wait", exampleWords: ["时候 (shí hou) - time/when", "等候 (děng hòu) - wait"], bookNumber: 2.1, lessonNumber: 7),
                    ChineseCharacter(character: "蛙", pinyin: "wā", meaning: "frog", exampleWords: ["青蛙 (qīng wā) - frog", "蛙声 (wā shēng) - frog sound"], bookNumber: 2.1, lessonNumber: 7),
                    ChineseCharacter(character: "蚧", pinyin: "jiè", meaning: "gecko", exampleWords: ["壁虎 (bì hǔ) - gecko", "蚧虫 (jiè chóng) - scale insect"], bookNumber: 2.1, lessonNumber: 7),
                    ChineseCharacter(character: "蝴", pinyin: "hú", meaning: "butterfly", exampleWords: ["蝴蝶 (hú dié) - butterfly", "蝴蝶花 (hú dié huā) - butterfly flower"], bookNumber: 2.1, lessonNumber: 7),
                    ChineseCharacter(character: "蝶", pinyin: "dié", meaning: "butterfly", exampleWords: ["蝴蝶 (hú dié) - butterfly", "蝶泳 (dié yǒng) - butterfly stroke"], bookNumber: 2.1, lessonNumber: 7),
                    ChineseCharacter(character: "毛", pinyin: "máo", meaning: "hair/fur", exampleWords: ["毛发 (máo fà) - hair", "羊毛 (yáng máo) - wool"], bookNumber: 2.1, lessonNumber: 7),
                    ChineseCharacter(character: "王", pinyin: "wáng", meaning: "king", exampleWords: ["国王 (guó wáng) - king", "王子 (wáng zǐ) - prince"], bookNumber: 2.1, lessonNumber: 7),
                    ChineseCharacter(character: "林", pinyin: "lín", meaning: "forest", exampleWords: ["森林 (sēn lín) - forest", "树林 (shù lín) - woods"], bookNumber: 2.1, lessonNumber: 7),
                    ChineseCharacter(character: "李", pinyin: "lǐ", meaning: "plum/surname", exampleWords: ["李子 (lǐ zi) - plum", "李老师 (lǐ lǎo shī) - Teacher Li"], bookNumber: 2.1, lessonNumber: 7)
                ]
            ),
            Lesson(
                bookNumber: 2.1,
                lessonNumber: 8,
                title: "Directions",
                characters: [
                    ChineseCharacter(character: "晴", pinyin: "qíng", meaning: "clear/sunny", exampleWords: ["晴天 (qíng tiān) - sunny day", "天晴 (tiān qíng) - clear weather"], bookNumber: 2.1, lessonNumber: 8),
                    ChineseCharacter(character: "东", pinyin: "dōng", meaning: "east", exampleWords: ["东方 (dōng fāng) - east", "东西 (dōng xi) - things"], bookNumber: 2.1, lessonNumber: 8),
                    ChineseCharacter(character: "西", pinyin: "xī", meaning: "west", exampleWords: ["西方 (xī fāng) - west", "东西 (dōng xi) - things"], bookNumber: 2.1, lessonNumber: 8),
                    ChineseCharacter(character: "南", pinyin: "nán", meaning: "south", exampleWords: ["南方 (nán fāng) - south", "南北 (nán běi) - north and south"], bookNumber: 2.1, lessonNumber: 8),
                    ChineseCharacter(character: "北", pinyin: "běi", meaning: "north", exampleWords: ["北方 (běi fāng) - north", "南北 (nán běi) - north and south"], bookNumber: 2.1, lessonNumber: 8),
                    ChineseCharacter(character: "数", pinyin: "shù", meaning: "number/count", exampleWords: ["数字 (shù zì) - number", "数学 (shù xué) - mathematics"], bookNumber: 2.1, lessonNumber: 8),
                    ChineseCharacter(character: "清", pinyin: "qīng", meaning: "clear/clean", exampleWords: ["清水 (qīng shuǐ) - clear water", "清楚 (qīng chu) - clear"], bookNumber: 2.1, lessonNumber: 8)
                ]
            ),
            Lesson(
                bookNumber: 2.1,
                lessonNumber: 9,
                title: "Movement and Position",
                characters: [
                    ChineseCharacter(character: "过", pinyin: "guò", meaning: "pass/cross", exampleWords: ["过来 (guò lái) - come over", "经过 (jīng guò) - pass by"], bookNumber: 2.1, lessonNumber: 9),
                    ChineseCharacter(character: "路", pinyin: "lù", meaning: "road/path", exampleWords: ["马路 (mǎ lù) - road", "走路 (zǒu lù) - walk"], bookNumber: 2.1, lessonNumber: 9),
                    ChineseCharacter(character: "左", pinyin: "zuǒ", meaning: "left", exampleWords: ["左边 (zuǒ biān) - left side", "左右 (zuǒ yòu) - left and right"], bookNumber: 2.1, lessonNumber: 9),
                    ChineseCharacter(character: "边", pinyin: "biān", meaning: "side/edge", exampleWords: ["旁边 (páng biān) - beside", "左边 (zuǒ biān) - left side"], bookNumber: 2.1, lessonNumber: 9),
                    ChineseCharacter(character: "右", pinyin: "yòu", meaning: "right", exampleWords: ["右边 (yòu biān) - right side", "左右 (zuǒ yòu) - left and right"], bookNumber: 2.1, lessonNumber: 9),
                    ChineseCharacter(character: "前", pinyin: "qián", meaning: "front/before", exampleWords: ["前面 (qián miàn) - in front", "以前 (yǐ qián) - before"], bookNumber: 2.1, lessonNumber: 9),
                    ChineseCharacter(character: "后", pinyin: "hòu", meaning: "back/after", exampleWords: ["后面 (hòu miàn) - behind", "以后 (yǐ hòu) - after"], bookNumber: 2.1, lessonNumber: 9),
                    ChineseCharacter(character: "停", pinyin: "tíng", meaning: "stop", exampleWords: ["停车 (tíng chē) - park car", "停止 (tíng zhǐ) - stop"], bookNumber: 2.1, lessonNumber: 9),
                    ChineseCharacter(character: "慢", pinyin: "màn", meaning: "slow", exampleWords: ["很慢 (hěn màn) - very slow", "慢慢 (màn màn) - slowly"], bookNumber: 2.1, lessonNumber: 9)
                ]
            ),
            Lesson(
                bookNumber: 2.1,
                lessonNumber: 10,
                title: "Body Parts",
                characters: [
                    ChineseCharacter(character: "眼", pinyin: "yǎn", meaning: "eye", exampleWords: ["眼睛 (yǎn jing) - eyes", "眼镜 (yǎn jìng) - glasses"], bookNumber: 2.1, lessonNumber: 10),
                    ChineseCharacter(character: "睛", pinyin: "jīng", meaning: "eyeball", exampleWords: ["眼睛 (yǎn jing) - eyes", "目不转睛 (mù bù zhuǎn jīng) - stare"], bookNumber: 2.1, lessonNumber: 10),
                    ChineseCharacter(character: "发", pinyin: "fà", meaning: "hair", exampleWords: ["头发 (tóu fà) - hair", "发型 (fà xíng) - hairstyle"], bookNumber: 2.1, lessonNumber: 10),
                    ChineseCharacter(character: "鼻", pinyin: "bí", meaning: "nose", exampleWords: ["鼻子 (bí zi) - nose", "鼻孔 (bí kǒng) - nostril"], bookNumber: 2.1, lessonNumber: 10),
                    ChineseCharacter(character: "朵", pinyin: "duǒ", meaning: "ear/flower", exampleWords: ["耳朵 (ěr duǒ) - ear", "花朵 (huā duǒ) - flower"], bookNumber: 2.1, lessonNumber: 10),
                    ChineseCharacter(character: "嘴", pinyin: "zuǐ", meaning: "mouth", exampleWords: ["嘴巴 (zuǐ ba) - mouth", "张嘴 (zhāng zuǐ) - open mouth"], bookNumber: 2.1, lessonNumber: 10),
                    ChineseCharacter(character: "脸", pinyin: "liǎn", meaning: "face", exampleWords: ["洗脸 (xǐ liǎn) - wash face", "脸蛋 (liǎn dàn) - cheek"], bookNumber: 2.1, lessonNumber: 10),
                    ChineseCharacter(character: "丁", pinyin: "dīng", meaning: "nail/person", exampleWords: ["园丁 (yuán dīng) - gardener", "人丁 (rén dīng) - population"], bookNumber: 2.1, lessonNumber: 10),
                    ChineseCharacter(character: "胖", pinyin: "pàng", meaning: "fat", exampleWords: ["很胖 (hěn pàng) - very fat", "胖子 (pàng zi) - fat person"], bookNumber: 2.1, lessonNumber: 10)
                ]
            ),
            Lesson(
                bookNumber: 2.1,
                lessonNumber: 11,
                title: "Reading and Learning",
                characters: [
                    ChineseCharacter(character: "尖", pinyin: "jiān", meaning: "sharp/pointed", exampleWords: ["尖锐 (jiān ruì) - sharp", "笔尖 (bǐ jiān) - pen tip"], bookNumber: 2.1, lessonNumber: 11),
                    ChineseCharacter(character: "读", pinyin: "dú", meaning: "read", exampleWords: ["读书 (dú shū) - read books", "朗读 (lǎng dú) - read aloud"], bookNumber: 2.1, lessonNumber: 11),
                    ChineseCharacter(character: "问", pinyin: "wèn", meaning: "ask", exampleWords: ["问题 (wèn tí) - question", "询问 (xún wèn) - inquire"], bookNumber: 2.1, lessonNumber: 11),
                    ChineseCharacter(character: "只", pinyin: "zhǐ", meaning: "only/measure word", exampleWords: ["只有 (zhǐ yǒu) - only have", "一只 (yī zhǐ) - one (animal)"], bookNumber: 2.1, lessonNumber: 11),
                    ChineseCharacter(character: "进", pinyin: "jìn", meaning: "enter", exampleWords: ["进来 (jìn lái) - come in", "进入 (jìn rù) - enter"], bookNumber: 2.1, lessonNumber: 11),
                    ChineseCharacter(character: "对", pinyin: "duì", meaning: "correct/towards", exampleWords: ["对的 (duì de) - correct", "面对 (miàn duì) - face"], bookNumber: 2.1, lessonNumber: 11),
                    ChineseCharacter(character: "在", pinyin: "zài", meaning: "at/in", exampleWords: ["在家 (zài jiā) - at home", "现在 (xiàn zài) - now"], bookNumber: 2.1, lessonNumber: 11)
                ]
            ),
            Lesson(
                bookNumber: 2.1,
                lessonNumber: 12,
                title: "Places and Things",
                characters: [
                    ChineseCharacter(character: "城", pinyin: "chéng", meaning: "city", exampleWords: ["城市 (chéng shì) - city", "长城 (cháng chéng) - Great Wall"], bookNumber: 2.1, lessonNumber: 12),
                    ChineseCharacter(character: "背", pinyin: "bèi", meaning: "back/carry", exampleWords: ["背包 (bèi bāo) - backpack", "背后 (bèi hòu) - behind"], bookNumber: 2.1, lessonNumber: 12),
                    ChineseCharacter(character: "包", pinyin: "bāo", meaning: "bag/wrap", exampleWords: ["书包 (shū bāo) - school bag", "包子 (bāo zi) - steamed bun"], bookNumber: 2.1, lessonNumber: 12),
                    ChineseCharacter(character: "原", pinyin: "yuán", meaning: "original/plain", exampleWords: ["原来 (yuán lái) - originally", "草原 (cǎo yuán) - grassland"], bookNumber: 2.1, lessonNumber: 12),
                    ChineseCharacter(character: "骑", pinyin: "qí", meaning: "ride", exampleWords: ["骑车 (qí chē) - ride bike", "骑马 (qí mǎ) - ride horse"], bookNumber: 2.1, lessonNumber: 12),
                    ChineseCharacter(character: "乡", pinyin: "xiāng", meaning: "countryside", exampleWords: ["家乡 (jiā xiāng) - hometown", "乡村 (xiāng cūn) - village"], bookNumber: 2.1, lessonNumber: 12),
                    ChineseCharacter(character: "船", pinyin: "chuán", meaning: "boat", exampleWords: ["小船 (xiǎo chuán) - small boat", "轮船 (lún chuán) - steamship"], bookNumber: 2.1, lessonNumber: 12)
                ]
            ),
            Lesson(
                bookNumber: 2.1,
                lessonNumber: 13,
                title: "Class and Work",
                characters: [
                    ChineseCharacter(character: "班", pinyin: "bān", meaning: "class", exampleWords: ["班级 (bān jí) - class", "上班 (shàng bān) - go to work"], bookNumber: 2.1, lessonNumber: 13),
                    ChineseCharacter(character: "今", pinyin: "jīn", meaning: "today/now", exampleWords: ["今天 (jīn tiān) - today", "今年 (jīn nián) - this year"], bookNumber: 2.1, lessonNumber: 13),
                    ChineseCharacter(character: "级", pinyin: "jí", meaning: "grade/level", exampleWords: ["年级 (nián jí) - grade level", "班级 (bān jí) - class"], bookNumber: 2.1, lessonNumber: 13),
                    ChineseCharacter(character: "没", pinyin: "méi", meaning: "not have", exampleWords: ["没有 (méi yǒu) - don't have", "没关系 (méi guān xi) - no problem"], bookNumber: 2.1, lessonNumber: 13),
                    ChineseCharacter(character: "给", pinyin: "gěi", meaning: "give", exampleWords: ["给你 (gěi nǐ) - give you", "送给 (sòng gěi) - give as gift"], bookNumber: 2.1, lessonNumber: 13),
                    ChineseCharacter(character: "新", pinyin: "xīn", meaning: "new", exampleWords: ["新的 (xīn de) - new", "新年 (xīn nián) - new year"], bookNumber: 2.1, lessonNumber: 13),
                    ChineseCharacter(character: "作", pinyin: "zuò", meaning: "do/work", exampleWords: ["工作 (gōng zuò) - work", "作业 (zuò yè) - homework"], bookNumber: 2.1, lessonNumber: 13),
                    ChineseCharacter(character: "业", pinyin: "yè", meaning: "work/industry", exampleWords: ["作业 (zuò yè) - homework", "工业 (gōng yè) - industry"], bookNumber: 2.1, lessonNumber: 13),
                    ChineseCharacter(character: "龙", pinyin: "lóng", meaning: "dragon", exampleWords: ["龙舟 (lóng zhōu) - dragon boat", "恐龙 (kǒng lóng) - dinosaur"], bookNumber: 2.1, lessonNumber: 13)
                ]
            ),
            Lesson(
                bookNumber: 2.1,
                lessonNumber: 14,
                title: "Expectations and Activities",
                characters: [
                    ChineseCharacter(character: "期", pinyin: "qī", meaning: "period/expect", exampleWords: ["星期 (xīng qī) - week", "期待 (qī dài) - expect"], bookNumber: 2.1, lessonNumber: 14),
                    ChineseCharacter(character: "领", pinyin: "lǐng", meaning: "lead/collar", exampleWords: ["领导 (lǐng dǎo) - leader", "衣领 (yī lǐng) - collar"], bookNumber: 2.1, lessonNumber: 14),
                    ChineseCharacter(character: "泳", pinyin: "yǒng", meaning: "swim", exampleWords: ["游泳 (yóu yǒng) - swimming", "泳池 (yǒng chí) - swimming pool"], bookNumber: 2.1, lessonNumber: 14),
                    ChineseCharacter(character: "唱", pinyin: "chàng", meaning: "sing", exampleWords: ["唱歌 (chàng gē) - sing song", "合唱 (hé chàng) - chorus"], bookNumber: 2.1, lessonNumber: 14),
                    ChineseCharacter(character: "歌", pinyin: "gē", meaning: "song", exampleWords: ["唱歌 (chàng gē) - sing song", "歌曲 (gē qǔ) - song"], bookNumber: 2.1, lessonNumber: 14),
                    ChineseCharacter(character: "报", pinyin: "bào", meaning: "report/newspaper", exampleWords: ["报纸 (bào zhǐ) - newspaper", "报告 (bào gào) - report"], bookNumber: 2.1, lessonNumber: 14),
                    ChineseCharacter(character: "休", pinyin: "xiū", meaning: "rest", exampleWords: ["休息 (xiū xi) - rest", "休假 (xiū jià) - vacation"], bookNumber: 2.1, lessonNumber: 14),
                    ChineseCharacter(character: "息", pinyin: "xī", meaning: "rest/breath", exampleWords: ["休息 (xiū xi) - rest", "信息 (xìn xī) - information"], bookNumber: 2.1, lessonNumber: 14)
                ]
            ),
            Lesson(
                bookNumber: 2.1,
                lessonNumber: 15,
                title: "Festivals and Fun",
                characters: [
                    ChineseCharacter(character: "节", pinyin: "jié", meaning: "festival/section", exampleWords: ["节日 (jié rì) - festival", "春节 (chūn jié) - Spring Festival"], bookNumber: 2.1, lessonNumber: 15),
                    ChineseCharacter(character: "又", pinyin: "yòu", meaning: "again/also", exampleWords: ["又来了 (yòu lái le) - came again", "又大又好 (yòu dà yòu hǎo) - big and good"], bookNumber: 2.1, lessonNumber: 15),
                    ChineseCharacter(character: "圆", pinyin: "yuán", meaning: "round/circle", exampleWords: ["圆形 (yuán xíng) - round shape", "团圆 (tuán yuán) - reunion"], bookNumber: 2.1, lessonNumber: 15),
                    ChineseCharacter(character: "全", pinyin: "quán", meaning: "complete/all", exampleWords: ["全部 (quán bù) - all", "安全 (ān quán) - safe"], bookNumber: 2.1, lessonNumber: 15),
                    ChineseCharacter(character: "饼", pinyin: "bǐng", meaning: "cake/pancake", exampleWords: ["月饼 (yuè bǐng) - moon cake", "饼干 (bǐng gān) - biscuit"], bookNumber: 2.1, lessonNumber: 15),
                    ChineseCharacter(character: "什", pinyin: "shén", meaning: "what", exampleWords: ["什么 (shén me) - what", "为什么 (wèi shén me) - why"], bookNumber: 2.1, lessonNumber: 15),
                    ChineseCharacter(character: "么", pinyin: "me", meaning: "what/particle", exampleWords: ["什么 (shén me) - what", "怎么 (zěn me) - how"], bookNumber: 2.1, lessonNumber: 15),
                    ChineseCharacter(character: "喜", pinyin: "xǐ", meaning: "happy/like", exampleWords: ["喜欢 (xǐ huan) - like", "欢喜 (huān xǐ) - joy"], bookNumber: 2.1, lessonNumber: 15),
                    ChineseCharacter(character: "欢", pinyin: "huān", meaning: "happy/joy", exampleWords: ["喜欢 (xǐ huan) - like", "欢迎 (huān yíng) - welcome"], bookNumber: 2.1, lessonNumber: 15),
                    ChineseCharacter(character: "乐", pinyin: "lè", meaning: "happy/music", exampleWords: ["快乐 (kuài lè) - happy", "音乐 (yīn yuè) - music"], bookNumber: 2.1, lessonNumber: 15)
                ]
            ),
            Lesson(
                bookNumber: 2.1,
                lessonNumber: 16,
                title: "Food and Eating",
                characters: [
                    ChineseCharacter(character: "把", pinyin: "bǎ", meaning: "handle/take", exampleWords: ["把手 (bǎ shǒu) - handle", "把门 (bǎ mén) - door handle"], bookNumber: 2.1, lessonNumber: 16),
                    ChineseCharacter(character: "桃", pinyin: "táo", meaning: "peach", exampleWords: ["桃子 (táo zi) - peach", "桃花 (táo huā) - peach blossom"], bookNumber: 2.1, lessonNumber: 16),
                    ChineseCharacter(character: "肉", pinyin: "ròu", meaning: "meat", exampleWords: ["猪肉 (zhū ròu) - pork", "牛肉 (niú ròu) - beef"], bookNumber: 2.1, lessonNumber: 16),
                    ChineseCharacter(character: "菜", pinyin: "cài", meaning: "vegetable/dish", exampleWords: ["蔬菜 (shū cài) - vegetables", "菜单 (cài dān) - menu"], bookNumber: 2.1, lessonNumber: 16),
                    ChineseCharacter(character: "蚊", pinyin: "wén", meaning: "mosquito", exampleWords: ["蚊子 (wén zi) - mosquito", "蚊虫 (wén chóng) - mosquito"], bookNumber: 2.1, lessonNumber: 16),
                    ChineseCharacter(character: "真", pinyin: "zhēn", meaning: "real/true", exampleWords: ["真的 (zhēn de) - really", "认真 (rèn zhēn) - serious"], bookNumber: 2.1, lessonNumber: 16),
                    ChineseCharacter(character: "完", pinyin: "wán", meaning: "finish/complete", exampleWords: ["完成 (wán chéng) - complete", "做完 (zuò wán) - finish doing"], bookNumber: 2.1, lessonNumber: 16)
                ]
            ),
            Lesson(
                bookNumber: 2.1,
                lessonNumber: 17,
                title: "Nature and Body",
                characters: [
                    ChineseCharacter(character: "斑", pinyin: "bān", meaning: "spot/stripe", exampleWords: ["斑点 (bān diǎn) - spots", "斑马 (bān mǎ) - zebra"], bookNumber: 2.1, lessonNumber: 17),
                    ChineseCharacter(character: "苹", pinyin: "píng", meaning: "apple", exampleWords: ["苹果 (píng guǒ) - apple", "苹果树 (píng guǒ shù) - apple tree"], bookNumber: 2.1, lessonNumber: 17),
                    ChineseCharacter(character: "果", pinyin: "guǒ", meaning: "fruit/result", exampleWords: ["苹果 (píng guǒ) - apple", "水果 (shuǐ guǒ) - fruit"], bookNumber: 2.1, lessonNumber: 17),
                    ChineseCharacter(character: "香", pinyin: "xiāng", meaning: "fragrant", exampleWords: ["香味 (xiāng wèi) - fragrance", "香蕉 (xiāng jiāo) - banana"], bookNumber: 2.1, lessonNumber: 17),
                    ChineseCharacter(character: "蕉", pinyin: "jiāo", meaning: "banana", exampleWords: ["香蕉 (xiāng jiāo) - banana", "芭蕉 (bā jiāo) - plantain"], bookNumber: 2.1, lessonNumber: 17),
                    ChineseCharacter(character: "身", pinyin: "shēn", meaning: "body", exampleWords: ["身体 (shēn tǐ) - body", "全身 (quán shēn) - whole body"], bookNumber: 2.1, lessonNumber: 17),
                    ChineseCharacter(character: "会", pinyin: "huì", meaning: "can/meeting", exampleWords: ["会说 (huì shuō) - can speak", "开会 (kāi huì) - have meeting"], bookNumber: 2.1, lessonNumber: 17),
                    ChineseCharacter(character: "知", pinyin: "zhī", meaning: "know", exampleWords: ["知道 (zhī dào) - know", "知识 (zhī shi) - knowledge"], bookNumber: 2.1, lessonNumber: 17),
                    ChineseCharacter(character: "道", pinyin: "dào", meaning: "way/path", exampleWords: ["知道 (zhī dào) - know", "道路 (dào lù) - road"], bookNumber: 2.1, lessonNumber: 17),
                    ChineseCharacter(character: "聪", pinyin: "cōng", meaning: "intelligent", exampleWords: ["聪明 (cōng míng) - smart", "聪慧 (cōng huì) - intelligent"], bookNumber: 2.1, lessonNumber: 17),
                    ChineseCharacter(character: "明", pinyin: "míng", meaning: "bright/clear", exampleWords: ["聪明 (cōng míng) - smart", "明天 (míng tiān) - tomorrow"], bookNumber: 2.1, lessonNumber: 17)
                ]
            ),
            Lesson(
                bookNumber: 2.1,
                lessonNumber: 18,
                title: "Colors and Appearance",
                characters: [
                    ChineseCharacter(character: "颜", pinyin: "yán", meaning: "color/face", exampleWords: ["颜色 (yán sè) - color", "容颜 (róng yán) - appearance"], bookNumber: 2.1, lessonNumber: 18),
                    ChineseCharacter(character: "色", pinyin: "sè", meaning: "color", exampleWords: ["颜色 (yán sè) - color", "红色 (hóng sè) - red color"], bookNumber: 2.1, lessonNumber: 18),
                    ChineseCharacter(character: "刮", pinyin: "guā", meaning: "scrape/blow", exampleWords: ["刮风 (guā fēng) - windy", "刮胡子 (guā hú zi) - shave"], bookNumber: 2.1, lessonNumber: 18),
                    ChineseCharacter(character: "黄", pinyin: "huáng", meaning: "yellow", exampleWords: ["黄色 (huáng sè) - yellow", "黄金 (huáng jīn) - gold"], bookNumber: 2.1, lessonNumber: 18),
                    ChineseCharacter(character: "蓝", pinyin: "lán", meaning: "blue", exampleWords: ["蓝色 (lán sè) - blue", "蓝天 (lán tiān) - blue sky"], bookNumber: 2.1, lessonNumber: 18),
                    ChineseCharacter(character: "彩", pinyin: "cǎi", meaning: "color/colorful", exampleWords: ["彩色 (cǎi sè) - colorful", "彩虹 (cǎi hóng) - rainbow"], bookNumber: 2.1, lessonNumber: 18),
                    ChineseCharacter(character: "虹", pinyin: "hóng", meaning: "rainbow", exampleWords: ["彩虹 (cǎi hóng) - rainbow", "虹桥 (hóng qiáo) - rainbow bridge"], bookNumber: 2.1, lessonNumber: 18)
                ]
            ),
            Lesson(
                bookNumber: 2.1,
                lessonNumber: 19,
                title: "Water and Weather",
                characters: [
                    ChineseCharacter(character: "落", pinyin: "luò", meaning: "fall/drop", exampleWords: ["落下 (luò xià) - fall down", "日落 (rì luò) - sunset"], bookNumber: 2.1, lessonNumber: 19),
                    ChineseCharacter(character: "叶", pinyin: "yè", meaning: "leaf", exampleWords: ["树叶 (shù yè) - tree leaf", "叶子 (yè zi) - leaf"], bookNumber: 2.1, lessonNumber: 19),
                    ChineseCharacter(character: "气", pinyin: "qì", meaning: "air/gas", exampleWords: ["天气 (tiān qì) - weather", "空气 (kōng qì) - air"], bookNumber: 2.1, lessonNumber: 19),
                    ChineseCharacter(character: "凉", pinyin: "liáng", meaning: "cool", exampleWords: ["凉快 (liáng kuai) - cool", "凉水 (liáng shuǐ) - cool water"], bookNumber: 2.1, lessonNumber: 19),
                    ChineseCharacter(character: "片", pinyin: "piàn", meaning: "piece/slice", exampleWords: ["一片 (yī piàn) - one piece", "片刻 (piàn kè) - moment"], bookNumber: 2.1, lessonNumber: 19),
                    ChineseCharacter(character: "面", pinyin: "miàn", meaning: "face/surface", exampleWords: ["面条 (miàn tiáo) - noodles", "表面 (biǎo miàn) - surface"], bookNumber: 2.1, lessonNumber: 19),
                    ChineseCharacter(character: "河", pinyin: "hé", meaning: "river", exampleWords: ["河水 (hé shuǐ) - river water", "小河 (xiǎo hé) - small river"], bookNumber: 2.1, lessonNumber: 19),
                    ChineseCharacter(character: "妈", pinyin: "mā", meaning: "mother", exampleWords: ["妈妈 (mā ma) - mom", "母亲 (mǔ qīn) - mother"], bookNumber: 2.1, lessonNumber: 19),
                    ChineseCharacter(character: "蚁", pinyin: "yǐ", meaning: "ant", exampleWords: ["蚂蚁 (mǎ yǐ) - ant", "蚁穴 (yǐ xué) - ant nest"], bookNumber: 2.1, lessonNumber: 19),
                    ChineseCharacter(character: "信", pinyin: "xìn", meaning: "letter/believe", exampleWords: ["信件 (xìn jiàn) - letter", "相信 (xiāng xìn) - believe"], bookNumber: 2.1, lessonNumber: 19),
                    ChineseCharacter(character: "方", pinyin: "fāng", meaning: "square/direction", exampleWords: ["方向 (fāng xiàng) - direction", "地方 (dì fang) - place"], bookNumber: 2.1, lessonNumber: 19)
                ]
            ),
            Lesson(
                bookNumber: 2.1,
                lessonNumber: 20,
                title: "Final Concepts",
                characters: [
                    ChineseCharacter(character: "块", pinyin: "kuài", meaning: "piece/dollar", exampleWords: ["一块 (yī kuài) - one piece", "石块 (shí kuài) - stone piece"], bookNumber: 2.1, lessonNumber: 20),
                    ChineseCharacter(character: "放", pinyin: "fàng", meaning: "put/release", exampleWords: ["放下 (fàng xià) - put down", "放学 (fàng xué) - school dismissal"], bookNumber: 2.1, lessonNumber: 20),
                    ChineseCharacter(character: "盆", pinyin: "pén", meaning: "basin/pot", exampleWords: ["花盆 (huā pén) - flower pot", "脸盆 (liǎn pén) - wash basin"], bookNumber: 2.1, lessonNumber: 20),
                    ChineseCharacter(character: "等", pinyin: "děng", meaning: "wait/equal", exampleWords: ["等待 (děng dài) - wait", "等一下 (děng yī xià) - wait a moment"], bookNumber: 2.1, lessonNumber: 20),
                    ChineseCharacter(character: "到", pinyin: "dào", meaning: "arrive/to", exampleWords: ["到了 (dào le) - arrived", "到达 (dào dá) - reach"], bookNumber: 2.1, lessonNumber: 20),
                    ChineseCharacter(character: "哪", pinyin: "nǎ", meaning: "which", exampleWords: ["哪里 (nǎ lǐ) - where", "哪个 (nǎ gè) - which one"], bookNumber: 2.1, lessonNumber: 20),
                    ChineseCharacter(character: "出", pinyin: "chū", meaning: "out/exit", exampleWords: ["出来 (chū lái) - come out", "出去 (chū qù) - go out"], bookNumber: 2.1, lessonNumber: 20),
                    ChineseCharacter(character: "胜", pinyin: "shèng", meaning: "win/victory", exampleWords: ["胜利 (shèng lì) - victory", "获胜 (huò shèng) - win"], bookNumber: 2.1, lessonNumber: 20),
                    ChineseCharacter(character: "河", pinyin: "hé", meaning: "river", exampleWords: ["河流 (hé liú) - river", "黄河 (huáng hé) - Yellow River"], bookNumber: 2.1, lessonNumber: 20)
                ]
            ),
            Lesson(
                bookNumber: 2.1,
                lessonNumber: 21,
                title: "Advanced Concepts",
                characters: [
                    ChineseCharacter(character: "抱", pinyin: "bào", meaning: "hold/hug", exampleWords: ["拥抱 (yōng bào) - hug", "抱着 (bào zhe) - holding"], bookNumber: 2.1, lessonNumber: 21),
                    ChineseCharacter(character: "远", pinyin: "yuǎn", meaning: "far", exampleWords: ["很远 (hěn yuǎn) - very far", "远方 (yuǎn fāng) - distant place"], bookNumber: 2.1, lessonNumber: 21),
                    ChineseCharacter(character: "半", pinyin: "bàn", meaning: "half", exampleWords: ["一半 (yī bàn) - half", "半天 (bàn tiān) - half day"], bookNumber: 2.1, lessonNumber: 21),
                    ChineseCharacter(character: "成", pinyin: "chéng", meaning: "become/succeed", exampleWords: ["成功 (chéng gōng) - success", "变成 (biàn chéng) - become"], bookNumber: 2.1, lessonNumber: 21),
                    ChineseCharacter(character: "还", pinyin: "hái", meaning: "still/return", exampleWords: ["还有 (hái yǒu) - still have", "还是 (hái shi) - or"], bookNumber: 2.1, lessonNumber: 21),
                    ChineseCharacter(character: "现", pinyin: "xiàn", meaning: "present/appear", exampleWords: ["现在 (xiàn zài) - now", "发现 (fā xiàn) - discover"], bookNumber: 2.1, lessonNumber: 21),
                    ChineseCharacter(character: "比", pinyin: "bǐ", meaning: "compare", exampleWords: ["比较 (bǐ jiào) - compare", "比如 (bǐ rú) - for example"], bookNumber: 2.1, lessonNumber: 21)
                ]
            ),
            Lesson(
                bookNumber: 2.1,
                lessonNumber: 22,
                title: "Final Characters",
                characters: [
                    ChineseCharacter(character: "张", pinyin: "zhāng", meaning: "open/sheet", exampleWords: ["张开 (zhāng kāi) - open", "一张纸 (yī zhāng zhǐ) - one sheet of paper"], bookNumber: 2.1, lessonNumber: 22),
                    ChineseCharacter(character: "样", pinyin: "yàng", meaning: "kind/appearance", exampleWords: ["这样 (zhè yàng) - this way", "样子 (yàng zi) - appearance"], bookNumber: 2.1, lessonNumber: 22),
                    ChineseCharacter(character: "照", pinyin: "zhào", meaning: "shine/photo", exampleWords: ["照片 (zhào piàn) - photo", "照顾 (zhào gù) - take care"], bookNumber: 2.1, lessonNumber: 22),
                    ChineseCharacter(character: "着", pinyin: "zhe", meaning: "particle/wear", exampleWords: ["看着 (kàn zhe) - looking at", "穿着 (chuān zhe) - wearing"], bookNumber: 2.1, lessonNumber: 22),
                    ChineseCharacter(character: "角", pinyin: "jiǎo", meaning: "corner/horn", exampleWords: ["角落 (jiǎo luò) - corner", "三角 (sān jiǎo) - triangle"], bookNumber: 2.1, lessonNumber: 22),
                    ChineseCharacter(character: "题", pinyin: "tí", meaning: "topic/question", exampleWords: ["问题 (wèn tí) - question", "题目 (tí mù) - title"], bookNumber: 2.1, lessonNumber: 22),
                    ChineseCharacter(character: "膀", pinyin: "bǎng", meaning: "shoulder/wing", exampleWords: ["肩膀 (jiān bǎng) - shoulder", "翅膀 (chì bǎng) - wing"], bookNumber: 2.1, lessonNumber: 22)
                ]
            ),
            
            // Book 3 - New lessons
            Lesson(
                bookNumber: 3,
                lessonNumber: 1,
                title: "Basic Actions",
                characters: [
                    ChineseCharacter(character: "吃", pinyin: "chī", meaning: "eat", exampleWords: ["吃饭 (chī fàn) - eat meal", "吃苹果 (chī píng guǒ) - eat apple"], bookNumber: 3, lessonNumber: 1),
                    ChineseCharacter(character: "喝", pinyin: "hē", meaning: "drink", exampleWords: ["喝水 (hē shuǐ) - drink water", "喝茶 (hē chá) - drink tea"], bookNumber: 3, lessonNumber: 1),
                    ChineseCharacter(character: "睡", pinyin: "shuì", meaning: "sleep", exampleWords: ["睡觉 (shuì jiào) - sleep", "睡眠 (shuì mián) - sleep"], bookNumber: 3, lessonNumber: 1),
                    ChineseCharacter(character: "走", pinyin: "zǒu", meaning: "walk/go", exampleWords: ["走路 (zǒu lù) - walk", "走开 (zǒu kāi) - go away"], bookNumber: 3, lessonNumber: 1)
                ]
            )
        ]
        
        self.lessons = sampleLessons
        self.allCharacters = sampleLessons.flatMap { $0.characters }
    }
    
    // Get lessons for a specific book
    func getLessons(for bookNumber: Double) -> [Lesson] {
        return lessons.filter { $0.bookNumber == bookNumber }
    }
    
    // Get all unique book numbers
    func getAvailableBooks() -> [Double] {
        return Array(Set(lessons.map { $0.bookNumber })).sorted()
    }
    
    // Get characters from selected lessons
    func getCharacters(from selectedLessons: [Lesson]) -> [ChineseCharacter] {
        return selectedLessons.flatMap { $0.characters }
    }
    
    // Update character progress
    func updateCharacterProgress(_ character: ChineseCharacter, wasCorrect: Bool) {
        if let index = allCharacters.firstIndex(where: { $0.id == character.id }) {
            allCharacters[index].reviewCount += 1
            if wasCorrect {
                allCharacters[index].correctCount += 1
            }
            allCharacters[index].lastReviewed = Date()
        }
        
        // Also update in lessons
        for lessonIndex in lessons.indices {
            if let charIndex = lessons[lessonIndex].characters.firstIndex(where: { $0.id == character.id }) {
                lessons[lessonIndex].characters[charIndex].reviewCount += 1
                if wasCorrect {
                    lessons[lessonIndex].characters[charIndex].correctCount += 1
                }
                lessons[lessonIndex].characters[charIndex].lastReviewed = Date()
            }
        }
    }
    
    // Get learning statistics
    func getLearningStats() -> LearningStats {
        let studiedCharacters = allCharacters.filter { $0.reviewCount > 0 }
        let totalReviews = allCharacters.reduce(0) { $0 + $1.reviewCount }
        let totalCorrect = allCharacters.reduce(0) { $0 + $1.correctCount }
        let averageAccuracy = totalReviews > 0 ? Double(totalCorrect) / Double(totalReviews) : 0.0
        
        var difficultyCount: [DifficultyLevel: Int] = [:]
        for level in DifficultyLevel.allCases {
            difficultyCount[level] = allCharacters.filter { $0.difficultyLevel == level }.count
        }
        
        let recentSessions = allCharacters.compactMap { $0.lastReviewed }.sorted(by: >)
        
        return LearningStats(
            totalCharacters: allCharacters.count,
            charactersStudied: studiedCharacters.count,
            averageAccuracy: averageAccuracy,
            charactersByDifficulty: difficultyCount,
            recentSessions: Array(recentSessions.prefix(10))
        )
    }
}
