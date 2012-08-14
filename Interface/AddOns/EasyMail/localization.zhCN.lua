-- By wowui.cn

if ( GetLocale() == "zhCN" ) then

EASYMAIL_FORWARDTEXT = "引用";
EASYMAIL_CLEAROPTION = "清除";
EASYMAIL_ATTBUTTONTEXT = "收取所有";
EASYMAIL_CHECKALLTEXT = "标记所有";
EASYMAIL_CLEARALLTEXT = "清除所有";
EASYMAIL_GETALLTEXT = "拿取附件";
EASYMAIL_GUILDTEXT = "公会成员";
EASYMAIL_FRIENDSTEXT = "好友";
EASYMAIL_RECEIVEMONEY = "你获得金钱: %s %s";
EASYMAIL_FROMAUCTION = "(拍卖行 %s)";
EASYMAIL_FROM = "(来自 %s)";
EASYMAIL_MONEYSUBJECT = "金钱: %s";
EASYMAIL_TOTALMONEY = "从附件获得的总金钱数: %s";
EASYMAIL_NOTEXT = "<无文本>";
EASYMAIL_FORWARD_PREFIX = "FW:"

EASYMAIL_CLEARQUESTION = "清除所有的最近邮寄列表从EasyMail地址列表?";
EASYMAIL_CLEARMSG = "最近的邮寄列表地址已清除.";
EASYMAIL_DELNAMEQUESTION = "清除 %s 从地址列表?";
EASYMAIL_DELNAMEMSG = "已删除 %s 从地址列表.";
EASYMAIL_DELETEQUESTION = "删除来自 %s 的邮件?";
EASYMAIL_DELETEUNREADQUESTION = "删除来自 %s 的未读邮件?";
EASYMAIL_MAXLENMSG = "EasyMail 最近邮寄地址列表最大长度设置为 %i.";
EASYMAIL_AUTOADDMSG = "EasyMail 自动添加已登陆角色到最近邮寄地址列表: %s.";
EASYMAIL_GUILDMSG = "EasyMail 在地址下拉列表显示公会成员: %s.";
EASYMAIL_FRIENDSMSG = "EasyMail 在地址下拉列表显示好友: %s.";
EASYMAIL_CLICKGETMSG = "EasyMail 右键拿取附件: %s.";
EASYMAIL_CLICKDELMSG = "EasyMail 右键邮件删除: %s.";
EASYMAIL_DELPROMPTMSG = "EasyMail 右键点击立即删除已读邮件: %s.";
EASYMAIL_DELPENDINGMSG = "EasyMail 当拿取所有附件后删除拍卖所邮件: %s.";
EASYMAIL_MONEYMSG = "EasyMail 输出每封邮件获得的金钱到聊天窗口: %s.";
EASYMAIL_TOTALMSG = "EasyMail 输出获得的总的金钱到聊天窗口: %s.";
EASYMAIL_TOOLTIPMSG = "EasyMail 在收件箱物品上显示邮件内容: %s.";

EASYMAIL_CLEARHELPMSG = "清除所有的最近邮寄列表从地址列表.";
EASYMAIL_MAXLENHELPMSG = "修改最近邮寄地址列表的最大长度.";
EASYMAIL_AUTOADDHELPMSG = "自动添加已登陆角色到最近邮寄地址列表.";
EASYMAIL_GUILDHELPMSG = "在地址下拉列表中包含公会成员.";
EASYMAIL_FRIENDSHELPMSG = "在地址下拉列表中包含好友名字.";
EASYMAIL_CLICKGETHELPMSG = "启用 右键点击 在收件箱中拿取附件.";
EASYMAIL_CLICKDELHELPMSG = "启用 右键点击 在收件箱中删除邮件.";
EASYMAIL_DELPROMPTHELPMSG = "右键点击立即删除已读邮件.";
EASYMAIL_DELPENDINGHELPMSG = "当拿取所有附件后删除拍卖所邮件";
EASYMAIL_MONEYHELPMSG = "输出每封邮件获得的金钱到聊天窗口.";
EASYMAIL_TOTALHELPMSG = "输出获得的总的金钱到聊天窗口.";
EASYMAIL_TOOLTIPHELPMSG = "收件箱物品上显示邮件内容. 警告: 邮件将被标记为 "
   .."已读当邮件内容已显示. 邮件内容可能会延迟几秒后显示.";

EASYMAIL_CONFIG_HEADERINFO = "设置发送新邮件时默认使用最后一次的邮寄地址，允许"
   .."用户从地址下拉列表中选择收件地址.";
EASYMAIL_CONFIG_MAXLEN = "最大列表长度 (%i - %i):";
EASYMAIL_CONFIG_CLEARLIST = "清除最近的邮寄列表";
EASYMAIL_CONFIG_CLEARLISTBTNTEXT = "清除列表";
EASYMAIL_CONFIG_AUTOADD = "添加已登陆角色到最近邮寄地址列表";
EASYMAIL_CONFIG_GUILD = "增加公会成员到地址列表";
EASYMAIL_CONFIG_FRIENDS = "增加好友到地址列表";
EASYMAIL_CONFIG_CLICKGET = "右键点击 拿取附件";
EASYMAIL_CONFIG_CLICKDEL = "右键点击 邮件删除";
EASYMAIL_CONFIG_DELPROMPT = "立即删除已读邮件";
EASYMAIL_CONFIG_DELPENDING = "删除拍卖所邮件";
EASYMAIL_CONFIG_MONEY = "输出每封邮件获取的金钱";
EASYMAIL_CONFIG_TOTAL = "输出获得的总的金钱";
EASYMAIL_CONFIG_TOOLTIP = "在收件箱物品上显示邮件内容";

EASYMAIL_ERRINVALIDPARM = "无效的列表长度数值.";
EASYMAIL_ERROUTOFRANGE = "列表长度必须在 %i 和 %i 之间.";
EASYMAIL_ERRTOGGLE = "无效的参数. 使用 ON 或 OFF.";
EASYMAIL_ERRTIMEOUT = "不能拿取一个附件 %i 秒. 检测是否有足够的背包空间或是否是唯一的物品. "
   .."如果你有网路延迟问题, 请在以后尝试所有操作.";
EASYMAIL_ERRCOD = "不允许右键拿取付款收信邮件.";
EASYMAIL_ERRMAILATT = "右键拿取附件没有被启用.";
EASYMAIL_ERRDELETE = "右键删除右键没有被启用.";
EASYMAIL_ERRUNREAD = "不允许右键删除未读右键.";
end