package com.hifun.util;

/**
 * 参数检验工具类
 * @author: yuexia 
 * @since: 2016年4月4日 下午2:21:56 
 * @history:
 */
public class ParamUtil {

    /**
     * 检验applyFriend表的applyStatus字段
     * @param applyStatus 
     * @create: 2016年4月4日 下午2:24:49 yuexia
     * @history:
     */
    public static void checkApplyFriendApplyStatus(int applyStatus) {
        // 用户输入的参数只能为-1或2，其余参数均报exception
        if (applyStatus != -1 && applyStatus != 2) {
            throw new RuntimeException("applyFriend-applyStatus参数输入有误");
        }
    }

}
