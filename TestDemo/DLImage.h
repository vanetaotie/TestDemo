//
//  DLImage.h
//  DLAppStore
//
//  Created by ZhangGang on 14-2-11.
//  Copyright (c) 2014年 Archermind. All rights reserved.
//
//#define IMAGE(name)         [[ThemeManager sharedInstance] imageWithImageName:(name)]  // create image
//
//#define IMAGED(name)        [UIImage imageNamed:(name)]

#define IMAGE(name)           [[ThemeManager sharedInstance] imageWithGeneralName:(name)]
#define IMAGED(name)          [[ThemeManager sharedInstance] imageWithGeneralName:(name)]

//////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - Common Icon
//////////////////////////////////////////////////////////////////////////////////////////////////////
#define IMG_NAV_RIGHT_BTN_ON          IMAGE(@"common_nav_right_btn_default")
#define IMG_NAV_RIGHT_BTN_OFF         IMAGE(@"common_nav_right_btn_focus")
#define ICON_DEFAULT_APPICON          IMAGE(@"appDefaultIcon")
#define ICON_DEFAULT_APPTYPE          IMAGE(@"apptypeicon");
#define IMG_COMMON_BACK_DEFAULT       IMAGE(@"common_back_default")
#define IMG_COMMON_BACK_FOUCS         IMAGE(@"common_back_focus")
#define IMG_COMMON_MAIN_DEFAULT       IMAGE(@"common_main_default")
#define IMG_COMMON_MAIN_FOUCS         IMAGE(@"common_main_focus")
#define IMG_COMMON_TALK_DEFAULT       IMAGE(@"common_talk_default")
#define IMG_COMMON_TALK_FOUCS         IMAGE(@"common_talk_focus")
#define IMG_COMMON_STORE_DEFAULT      IMAGE(@"common_store_default")
#define IMG_COMMON_STORE_FOUCS        IMAGE(@"common_store_focus")
#define IMG_COMMON_APP_DEFAULT        IMAGE(@"common_app_default")
#define IMG_COMMON_APP_FOCUS          IMAGE(@"common_app_focus")
#define IMG_COMMON_SETTING_DEFAULT    IMAGE(@"common_setting_default")
#define IMG_COMMON_SETTING_FOUCS      IMAGE(@"common_setting_focus")
#define IMG_COMMON_SELECT_ITEM        IMAGE(@"setting_appLinkShake")
#define IMG_WELCOME_1                 IMAGE(@"common_welcome_1")
#define IMG_WELCOME_2                 IMAGE(@"common_welcome_2")
#define IMG_WELCOME_3                 IMAGE(@"common_welcome_3")
#define IMG_WELCOME_4                 IMAGE(@"common_welcome_4")
#define IMG_COMMON_AD_BG              IMAGED(@"common_page_ad.png")
#define IMG_COMMON_AD_BG_IPHONE5      IMAGED(@"common_page_ad-568h.png")
#define IMG_COMMON_AD_BG_MAM          IMAGED(@"common_page_ad_mam.png")
#define IMG_COMMON_AD_BG_IPHONE5_MAM  IMAGED(@"common_page_ad-568h_mam.png")
#define IMG_COMMON_LOCK_ACCOUT        IMAGE(@"common_lock_accout")
#define Pagecontrol_Normal_Image      IMAGE(@"common_page_disable")
#define Pagecontrol_Select_Image      IMAGE(@"common_page_active")
#define IMG_COMMON_LINE               IMAGE(@"new_common_line")

#define IMG_APPLY_GOBACK              IMAGED(@"apply_goback")
#define IMG_APPLY_GOFORWARD           IMAGED(@"apply_goforward")
#define IMG_APPLY_QUIT                IMAGED(@"apply_quit")
#define IMG_APPLY_REFRESH             IMAGED(@"apply_refresh")
#define IMG_APPLY_ACCOUNT             IMAGED(@"apply_account")
#define IMG_ACCOUNT_HEAD              IMAGED(@"account_head")
#define IMG_ACCOUNT_HEAD_SELECT       IMAGED(@"account_head_select")

#define IMG_CORDOVA_FUNCTION1         IMAGED(@"cordova_func1")
#define IMG_CORDOVA_FUNCTION2         IMAGED(@"cordova_func2")
#define IMG_CORDOVA_FUCNTION3         IMAGED(@"cordova_func3")

#define IMG_WEBVIEW_BACK_DEFAULT      IMAGE(@"webview_back_default")
#define IMG_WEBVIEW_FORWARD_DEFAULT   IMAGE(@"webview_forward_default")
#define IMG_WEBVIEW_REFRESH_DEFAULT   IMAGE(@"webview_refresh_default")
#define IMG_WEBVIEW_STOP_DEFAULT      IMAGE(@"webview_stop_default")
#define IMG_WEBVIEW_BACK_FOCUS        IMAGE(@"webview_back_focus")
#define IMG_WEBVIEW_FORWARD_FOCUS     IMAGE(@"webview_forward_focus")
#define IMG_WEBVIEW_REFRESH_FOCUS     IMAGE(@"webview_refresh_focus")
#define IMG_WEBVIEW_STOP_FOCUS        IMAGE(@"webview_stop_focus")

#define IMG_WEBVIEW_MORE_UP           IMAGE(@"webview_more_up")
#define IMG_WEBVIEW_MORE_DOWN         IMAGE(@"webview_more_down")
#define IMG_WEBVIEW_MORE_QUIT_UP      IMAGE(@"webview_more_quit_up")
#define IMG_WEBVIEW_MORE_QUIT_DOWN    IMAGE(@"webview_more_quit_down")
#define IMG_WEBVIEW_MORE_REFRESH_UP   IMAGE(@"webview_more_refresh_up")
#define IMG_WEBVIEW_MORE_REFRESH_DOWN IMAGE(@"webview_more_refresh_down")
#define IMG_WEBVIEW_MORE_BACK_UP      IMAGE(@"webview_more_back_up")
#define IMG_WEBVIEW_MORE_BACK_DOWN    IMAGE(@"webview_more_back_down")
#define IMG_WEBVIEW_MORE_FORWARD_UP   IMAGE(@"webview_more_forward_up")
#define IMG_WEBVIEW_MORE_FORWARD_DOWN IMAGE(@"webview_more_forward_down")
#define IMG_PERSON_DYNAMIC_MORE_DEFAULT         IMAGE(@"person_dynamic_more_default")
#define IMG_PERSON_DYNAMIC_MORE_FOCUS           IMAGE(@"person_dynamic_more_focus")
#define IMG_MYCIRCLE_DISTRIBUTE_DEFAULT         IMAGE(@"mycircle_distribute_default")
#define IMG_MYCIRCLE_DISTRIBUTE_FOCUS           IMAGE(@"mycircle_distribute_focus")

//////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - Login Icon
//////////////////////////////////////////////////////////////////////////////////////////////////////
#define IMG_LOGIN_LOGO               IMAGE(@"login_logo")
#define IMG_LOGIN_BG                 IMAGE(@"login_bg")
#define IMG_LOGIN_LINE               IMAGE(@"login_line")
#define IMG_VERIFY_LODING            IMAGE(@"verify_loading")
#define IMG_VERIFY_BTN_DEFAULT       IMAGE(@"verify_btn_default")
#define IMG_LOGIN_BTN_DEFAULT        IMAGE(@"login_btn_default")
#define IMG_LOGIN_BTN_FOCUS          IMAGE(@"login_btn_focus")
#define IMG_LOGIN_BTN_ON             IMAGE(@"login_btn_on")
#define IMG_LOGIN_BTN_OFF            IMAGE(@"login_btn_off")
#define IMG_LOGIN_VIEW_BG            IMAGE(@"login_view_bg")
#define IMG_LOGIN_TITLE_ICON         IMAGE(@"login_title_icon")
#define IMG_LOGIN_COMBOX_BG          IMAGE(@"login_combox_bg")
#define IMG_LOGIN_COMBOX_ACCESSORY   IMAGE(@"login_combox_accessory")
#define IMG_CHECKBOX_SELECETED       IMAGE(@"checkbox_selected")
#define IMG_CHECKBOX_DEFAULT         IMAGE(@"checkbox_default")
#define IMG_VERIFY_MATCH_ERROR       IMAGED(@"verify_match_error.png")
#define IMG_VERIFY_MATCH_RIGHT       IMAGED(@"verfy_match_right.png")
#define IMG_LOGIN_BTN_CANCEL_FOCUS   IMAGE(@"login_btn_cancel_focus")
#define IMG_LOGIN_BTN_CANCEL_DEFAULT IMAGE(@"login_btn_cancel_default")
#define IMG_LOGIN_BTN_COMMIT_FOCUS   IMAGE(@"login_btn_commit_focus")
#define IMG_LOGIN_BTN_COMMIT_DEFAULT IMAGE(@"login_btn_commit_default")
#define IMG_LOGIN_TEXTFIELD_BG       IMAGE(@"login_textfield_bg")
#define IMG_LOGINT_TEXTFIELD_SHORT   IMAGE(@"login_textfield_short")
#define IMG_LOGIN_PWD_ICON           IMAGE(@"login_pwd_icon")
#define IMG_LOGIN_USER_ICON          IMAGE(@"login_user_icon")
#define IMG_LOGIN_VERIFY_ICON        IMAGE(@"login_verify_icon")
#define IMG_LOGIN_HEADER             IMAGE(@"logo_header")
#define IMG_BTN_PASSTURE             IMAGE(@"btn_login_passture")
#define IMG_BTN_LOGIN_BG             IMAGE(@"new_btn_login_bg")
#define IMG_LOGIN_TIMER_BG           IMAGE(@"btn_login_passture_false")
#define IMG_LOGIN_PHONE_LINE         IMAGE(@"login_phone_line")
#define IMG_LOGIN_PHONE_ICON         IMAGE(@"login_phone_icon")
#define IMG_LOGIN_PHONE_SEETING      IMAGED(@"login_phone_setting")
#define IMG_LOGIN_BTN_EYE_FOCUS      IMAGED(@"login_btn_eye_focus")
#define IMG_LOGIN_BTN_EYE_DEFAULT    IMAGED(@"login_btn_eye_default")
#define IMG_LOGIN_PIC_CODE_LOADING   IMAGE(@"login_pic_code_loading")


#define IMG_ACTIONSHEET_CANCEL       IMAGE(@"lxsheet_cancelbtn")
#define IMG_ACTIONSHEET_DESTROY      IMAGE(@"lxsheet_destroybtn")
#define IMG_ACTIONSHEET_OTHER        IMAGE(@"lxsheet_otherbtn2")

//////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - MainPage Icon
//////////////////////////////////////////////////////////////////////////////////////////////////////
#define IMG_MAINPAGE_TIP_BG  IMAGE(@"mainPage_Tip_bg")
#define IMG_UNREAD_ICON      IMAGE(@"icon_unread")
#define IMG_ADD_ICON         IMAGE(@"icon_add_app")

#define IMG_ACCESSOYR_ICON   IMAGE(@"icon_accessory")
#define IMG_COLLECT_APP      IMAGE(@"icon_collect_app")
#define IMG_NO_DATA          IMAGE(@"icon_no_data")
#define IMG_NO_COMMENT       IMAGED(@"icon_no_comment")
#define IMG_NO_APP_DATA      IMAGE(@"icon_no_app_data")
#define IMG_NO_COLLECT_DATA  IMAGE(@"icon_no_collect_data")
#define IMG_NO_MSG_DATA      IMAGE(@"icon_no_msg")

#define IMG_MSG_CENTER_ICON  IMAGED(@"icon_msg_center.png")
#define IMG_ADD_APP_ICON     IMAGE(@"icon_addapp")
#define IMG_DEL_APP_ICON     IMAGE(@"icon_delapp")
#define IMG_SLIDER_LONG      IMAGE(@"slide_long")
#define IMG_SLIDER_POINT     IMAGE(@"slide_point")
#define IMG_TODO_LINE        IMAGE(@"todo_line")
#define IMG_CENTER_SHADOW    IMAGE(@"center_shadow")
#define IMG_APP_DEFAULT_ICON IMAGE(@"icon_app_default")
#define IMG_TAB_BAR          IMAGE(@"tab_bar")
#define IMG_NO_MATTER_ICON   IMAGE(@"icon_no_matter")
#define IMG_APP_DEFAULT_MASK_ICON IMAGED(@"icon_app_default_mask.png")
#define IMG_APP_SYNC_MASK_ICON    IMAGED(@"icon_app_sync_mask.png")
#define IMG_APP_MAIN_INTRODUCE    IMAGED(@"mainpage_introduceImg")
#define IMG_SUBSCRIPTION_REFRESH  IMAGED(@"icon_subscription_refresh")

//////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - Myself Icon
//////////////////////////////////////////////////////////////////////////////////////////////////////

#define IMG_GESTURE_ON                IMAGE(@"new_gesture_on")
#define IMG_GESTURE_OFF               IMAGE(@"new_gesture__off")
#define IMG_SMALL_CIRCLE_ON           IMAGE(@"gesture__small_on")
#define IMG_SMALL_CIRCLE_OFF          IMAGE(@"gesture_small_off")
#define IMG_SETTING_RECORD_DETAIL     IMAGE(@"setting_record_detail")
#define IMG_SETTING_START_RECORD_ON   IMAGE(@"setting_start_record_on")
#define IMG_SETTING_START_RECORD_OFF  IMAGE(@"setting_start_record_off")
#define IMG_SETTING_RECORD_ON         IMAGE(@"setting_record_on")
#define IMG_SETTING_RECORD_OFF        IMAGE(@"setting_record_off")
#define IMG_SETTING_HISTORY_ON        IMAGE(@"setting_history_on")
#define IMG_SETTING_HISTORY_OFF       IMAGE(@"setting_history_off")
#define IMG_SETTING_VOICE             IMAGE(@"setting_vocie")
#define IMG_SETTING_NOTICE            IMAGED(@"setting_notice")
#define IMG_SETTING                   IMAGE(@"setting_setting")
#define IMG_SHAKE                     IMAGE(@"setting_shake")
#define IMG_ADVICE                    IMAGE(@"setting_advice")
#define IMG_ABOUT                     IMAGE(@"setting_about")
#define IMG_MSG_OPEN                  IMAGE(@"msg_opn")
#define IMG_MSG_UNOPEN                IMAGE(@"msg_unopn")
#define IMG_APPLINK_SHAKE             IMAGE(@"setting_appLinkShake")
#define IMG_MSG                       IMAGE(@"setting_msg")
#define IMG_MSG_OPEN                  IMAGE(@"msg_opn")
#define IMG_95598_CLICK               IMAGE(@"95598_click")
#define IMG_95598                     IMAGE(@"95598")
#define IMG_REMOTE_LOCK               IMAGE(@"remote_lock")
#define IMG_SETTING_LINE              IMAGE(@"setting_line")
#define IMG_SETTING_PON               IMAGE(@"setting_pon")
#define IMG_ACCOUT_BG                 IMAGE(@"bind_accout_bg")
#define IMG_ACCOUT_LINE               IMAGE(@"bind_accout_line")
#define IMG_BING_SUCCESS              IMAGE(@"bind_success")
#define IMG_SETTING_ACCOUT            IMAGE(@"setting_account")
#define IMG_SETTING_CNOSNO            IMAGE(@"setting_consno")
#define IMG_SETTING_QUIT              IMAGE(@"setting_quit")
#define IMG_SETTING_FINISH_ON         IMAGE(@"setting_finish_default")
#define IMG_SETTING_FINISH_OFF        IMAGE(@"setting_finish_focus")
#define IMG_SETTING_LARGE_ON          IMAGE(@"setting_large_default")
#define IMG_SETTING_LARGE_OFF         IMAGE(@"setting_large_focus")
#define IMG_BTU_DO                    IMAGE(@"new_btu_do")
#define IMG_BTU_DO_SELECT             IMAGE(@"new_btu_do_select")
#define IMG_BTU_CANCEL                IMAGE(@"btu_cancel")
#define IMG_BTU_CANCEL_SELECT         IMAGE(@"btu_cancel_select")
#define IMG_BTU_DELETE                IMAGED(@"btu_delete")
#define IMG_BTU_DELETE_SELECT         IMAGED(@"btu_delete_select")
#define IMG_SETTING_CANCEL_ON         IMAGE(@"setting_cancel_default")
#define IMG_SETTING_CANCEL_OFF        IMAGE(@"setting_cancel_focus")
#define IMG_SETTING_SHARE             IMAGE(@"setting_share")
#define IMG_SETTING_CHANGE            IMAGE(@"setting_change")
#define IMG_SETTING_TIME              IMAGE(@"new_setting_time")
#define IMG_SETTING_DATE              IMAGE(@"setting_date")
#define IMG_SETTING_DATE_SELECT       IMAGE(@"new_setting_date_select")
#define IMG_SETTING_SLIENT            IMAGE(@"setting_slient")
#define IMG_SETTING_FEEDBACK          IMAGE(@"setting_feedback")
#define IMG_SETTING_PLAY1             IMAGED(@"setting_play1")
#define IMG_SETTING_PLAY2             IMAGED(@"setting_play2")
#define IMG_SETTING_PLAY3             IMAGED(@"setting_play3")
#define IMG_SETTING_MSG_DID           IMAGE(@"setting_msg_did")
#define IMG_SETTING_MSG               IMAGE(@"setting_msg")
#define IMG_SETTING_MSG_NOTICE        IMAGE(@"setting_msg_notice")
#define IMG_SETTING_SELECT_TIME       IMAGE(@"setting_selecttime")
#define IMG_SETTING_BG_CENTER         IMAGE(@"setting_bg_center")
#define IMG_SETTING_BG_TOP            IMAGE(@"setting_bg_top")
#define IMG_SETTING_BG_FOOT           IMAGE(@"setting_bg_foot")
#define IMG_DOWNLOAD_POINT            IMAGE(@"download_point")
#define IMG_FORGET_PWD_BTN_ON         IMAGE(@"setting_forget_pwd_default")
#define IMG_FORGET_PWD_BTN_OFF        IMAGE(@"setting_forget_pwd_focus")
#define IMG_SETTING_BG_SELECT         IMAGED(@"setting_bg_select")
#define IMG_SETTING_BG                IMAGE(@"setting_bg")
#define IMG_SETTING_PERSONAL_ON       IMAGE(@"setting_personal_defualt")
#define IMG_SETTING_PERSONAL_OFF      IMAGE(@"setting_personal_focus")
#define IMG_SETTING_CONSNO_ON         IMAGE(@"setting_consno_default")
#define IMG_SETTING_CONSNO_OFF        IMAGE(@"setting_consno_focus")
#define IMG_SETTING_MSGCENTER_ON      IMAGE(@"setting_msgCenter_default")
#define IMG_SETTING_MSGCENTER_OFF     IMAGE(@"setting_msgCenter_focus")
#define IMG_SETTING_CONSNO_ICON       IMAGE(@"setting_consno_icon")
#define IMG_SETTING_MSGCENTER_ICON    IMAGE(@"setting_msgCenter_icon")
#define IMG_SETTING_PERSON            IMAGED(@"img_setting_person")
#define IMG_QIXIN_MSGCENTER           IMAGED(@"img_qixin_msgcenter")
#define IMG_DEFAULT_TOPICICON         IMAGED(@"default_topic_icon")
#define IMG_DEFAULT_TOPICIMG_SMALL1   IMAGED(@"default_topic_small1")
#define IMG_DEFAULT_TOPICIMG_SMALL2   IMAGED(@"default_topic_small2")
#define IMG_DEFAULT_TOPICIMG_SMALL3   IMAGED(@"default_topic_small3")
#define IMG_DEFAULT_TOPICIMG_SMALL4   IMAGED(@"default_topic_small4")
#define IMG_DEFAULT_TOPICIMG_BIG1     IMAGED(@"default_topic_big1")
#define IMG_DEFAULT_TOPICIMG_BIG2     IMAGED(@"default_topic_big2")
#define IMG_DEFAULT_TOPICIMG_BIG3     IMAGED(@"default_topic_big3")
#define IMG_DEFAULT_TOPICIMG_BIG4     IMAGED(@"default_topic_big4")
#define IMG_TOPIC_DETAIL_BTNHIGHLIGHT IMAGE(@"new_btu_do_select_highlight")
#define IMG_BACKGROUND_DEFAULT        IMAGED(@"backgroud_default")
#define IMG_SETTING_COLLECT_ICON      IMAGE(@"setting_collect_icon")
#define IMG_SETTING_COLLECT           IMAGE(@"setting_collect")
#define IMG_SETTING_DELETE_RECORD     IMAGED(@"setting_delete_record_off")

//////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - QrCode Icon二维码
//////////////////////////////////////////////////////////////////////////////////////////////////////
#define IMG_QRCODE_PUB       IMAGED(@"pubtest")
#define IMG_QRCODE_PUB_SMALL IMAGED(@"pubtest-small")

#define IMG_QRCODE_MOB       IMAGED(@"mobile")
#define IMG_QRCODE_MOB_SMALL IMAGED(@"moblie-small")

//////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - ChangeUser  Image
//////////////////////////////////////////////////////////////////////////////////////////////////////
#define IMG_CHANGE_USER_1      IMAGE(@"changeUser_1")
#define IMG_CHANGE_USER_2      IMAGE(@"changeUser_2")
#define IMG_CHANGE_USER_1_DOWN IMAGE(@"changeUser_1_down")
#define IMG_CHANGE_USER_2_DOWN IMAGE(@"changeUser_2_down")
#define IMG_CHANGE_ICON        IMAGE(@"change_icon")
#define IMG_CHANGE_USER_3      IMAGE(@"changeUser_3")
#define IMG_CHANGE_USER_3_DOWN IMAGE(@"changeUser_3_down")
#define IMG_USER_SELECTED      IMAGE(@"icon_header_press")
#define IMG_USER_NOT_SELECTED  IMAGE(@"icon_header")

//////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - shareIcon  Image
//////////////////////////////////////////////////////////////////////////////////////////////////////
#define IMG_SNS_ICON_1  IMAGED(@"sns_icon_1")
#define IMG_SNS_ICON_2  IMAGED(@"sns_icon_2")
#define IMG_SNS_ICON_18 IMAGED(@"sns_icon_18")
#define IMG_SNS_ICON_19 IMAGED(@"sns_icon_19")
#define IMG_SNS_ICON_22 IMAGED(@"sns_icon_22")
#define IMG_SNS_ICON_23 IMAGED(@"sns_icon_23")
#define IMG_SNS_ICON_24 IMAGED(@"sns_icon_24")
#define IMG_SNS_ICON_38 IMAGED(@"sns_icon_38")
#define IMG_SNS_ICON_39 IMAGED(@"sns_icon_39")

//////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - 商店应用  Image
//////////////////////////////////////////////////////////////////////////////////////////////////////
#define IMG_APP_SETUP              IMAGE(@"store_setup_btn")
#define IMG_APP_SETUP_HL           IMAGE(@"store_setup_btn_HL")
#define IMG_SEARCH                 IMAGE(@"searchBar_search")
#define IMG_SEARCH_NEW             IMAGE(@"searchBar_search_new")
#define IMG_SEARCH_BG              IMAGE(@"searchBar_bg")
#define IMG_SEARCH_NOAPP           IMAGE(@"searchBar_noApp")
#define IMG_ACTION_DOWN            IMAGE(@"action_down")
#define IMG_ACTION_DOWN_SELECT     IMAGE(@"action_down_select")
#define IMG_ACTION_FRESH           IMAGE(@"action_fresh")
#define IMG_ACTION_FRESH_SELECT    IMAGE(@"action_fresh_select")
#define IMG_ACTION_SERCH           IMAGE(@"action_serch")
#define IMG_ACTION_SERCH_SELECT    IMAGE(@"action_serch_select")
#define IMG_SHOP_BTN               IMAGE(@"new_btu_shop")
#define IMG_SHOP_BTN_SELECT        IMAGE(@"btu_shop_HL")
#define IMG_SHOP_INSTALLING        IMAGE(@"new_btu_shop_updata")
#define IMG_SHOP_INSTALLING_HL     IMAGE(@"new_btu_shop_updata_sele")
#define IMG_SHOP_BG_CELL           IMAGE(@"shop_bg_cell")
#define IMG_SHOP_BG_LINE           IMAGE(@"shop_bg_line")
#define IMG_SHOP_ICON_UPDATA       IMAGE(@"shop_icon_updata")
#define IMG_SHOP_TAB_BAR           IMAGE(@"new_shop_tab_bar")
#define IMG_BTN_SHOP_UPDATA        IMAGE(@"shop_btu_updata")
#define IMG_BTN_SHOP_UPDATA_SELECT IMAGE(@"shop_btu_updata_select")
#define IMG_SHOP_APPICON_BG        IMAGE(@"shop_appicon_bg")
#define IMG_SHOP_DOWN_CANCAL       IMAGE(@"down_cancal")
#define IMG_SHOP_UPDATE_OPN        IMAGE(@"shop_update_opn")
#define IMG_SHOP_UPDATE_UNOPN      IMAGE(@"shop_update_unopn")
#define IMG_DOWN_UPDATE            IMAGE(@"icon_updata_ios")

/***下载图片****/
#define IMG_DOWN_DEL               IMAGED(@"down_del")
#define IMG_DOWN_DEL_SELECT        IMAGED(@"down_del_select")
#define IMG_DOWN_PLAY              IMAGE(@"down_play")
#define IMG_DOWN_PLAY_SELECT       IMAGE(@"down_play_select")
#define IMG_DOWN_STOP              IMAGE(@"down_stop")
#define IMG_DOWN_STOP_SELECT       IMAGE(@"down_stop_select")
#define IMG_SHOP_DETAIL_SMALL      IMAGE(@"new_shop_detail_small")
#define IMG_SHOP_DETAIL_BIG        IMAGE(@"shop_detail_big")

#define IMG_STAR_DEFAULT           IMAGED(@"StarEmpty")
#define IMG_STAR_SELETE            IMAGED(@"StarFull")

#define IMG_DOWN_ARROW             IMAGED(@"down_arrow")
#define IMG_DOWN_ARROW_DOWN        IMAGED(@"down_arrow_down")
//////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - 待办事宜
//////////////////////////////////////////////////////////////////////////////////////////////////////
#define IMG_MESS_POINT_LIST      IMAGE(@"d_mess_point_list")
#define IMG_MESS_POINT_LIST1     IMAGE(@"d_mess_point_list1")
#define IMG_TODO_LINEA1          IMAGE(@"d_todo_line")
#define IMG_ICON_PLUG            IMAGE(@"d_icon_plug")
#define IMG_D_WAITING_RED        IMAGE(@"d_waiting_red")
#define IMG_D_WAITING_YEL        IMAGE(@"d_waiting_yel")
#define IMG_D_WAITING_GREEN      IMAGE(@"d_waiting_green")
#define IMG_D_WAITING_GRAY       IMAGE(@"d_waiting_gray")
#define IMG_D_FINISH_RED         IMAGE(@"d_finish_red")
#define IMG_D_FINISH_YEL         IMAGE(@"d_finish_yel")
#define IMG_D_FINISH_GREEN       IMAGE(@"d_finish_green")
#define IMG_D_FINISH_GRAY        IMAGE(@"d_finish_gray")
#define IMG_D_HISTORY_RED        IMAGE(@"d_history_red")
#define IMG_D_HISTORY_YEL        IMAGE(@"d_history_yel")
#define IMG_D_HISTORY_GREEN      IMAGE(@"d_history_green")
#define IMG_D_HISTORY_GRAY       IMAGE(@"d_history_gray")

#define IMG_D_EMAIL_RED          IMAGE(@"d_email_red")
#define IMG_D_EMAIL_RED_H        IMAGE(@"d_email_red_h")
#define IMG_D_EMAIL_RED_F        IMAGE(@"d_email_red_f")
#define IMG_D_EMAIL_YELLOW       IMAGE(@"d_email_yellow")
#define IMG_D_EMAIL_YELLOW_H     IMAGE(@"d_email_yellow_h")
#define IMG_D_EMAIL_YELLOW_F     IMAGE(@"d_email_yellow_f")
#define IMG_D_EMAIL_GREEN        IMAGE(@"d_email_green")
#define IMG_D_EMAIL_GREEN_H      IMAGE(@"d_email_green_h")
#define IMG_D_EMAIL_GREEN_F      IMAGE(@"d_email_green_f")
#define IMG_D_EMAIL_GRAY         IMAGE(@"d_email_gray")
#define IMG_D_EMAIL_GRAY_H       IMAGE(@"d_email_gray_h")
#define IMG_D_EMAIL_GRAY_F       IMAGE(@"d_email_gray_f")

#define IMG_D_CUSTOMER_RED       IMAGE(@"d_customer_red")
#define IMG_D_CUSTOMER_RED_H     IMAGE(@"d_customer_red_h")
#define IMG_D_CUSTOMER_RED_F     IMAGE(@"d_customer_red_f")
#define IMG_D_CUSTOMER_YELLOW    IMAGE(@"d_customer_yellow")
#define IMG_D_CUSTOMER_YELLOW_H  IMAGE(@"d_customer_yellow_h")
#define IMG_D_CUSTOMER_YELLOW_F  IMAGE(@"d_customer_yellow_f")
#define IMG_D_CUSTOMER_GREEN     IMAGE(@"d_customer_green")
#define IMG_D_CUSTOMER_GREEN_H   IMAGE(@"d_customer_green_h")
#define IMG_D_CUSTOMER_GREEN_F   IMAGE(@"d_customer_green_f")
#define IMG_D_CUSTOMER_GRAY      IMAGE(@"d_customer_gray")
#define IMG_D_CUSTOMER_GRAY_H    IMAGE(@"d_customer_gray_h")
#define IMG_D_CUSTOMER_GRAY_F    IMAGE(@"d_customer_gray_f")

#define IMG_D_MARKETING_RED      IMAGE(@"d_marketing_red")
#define IMG_D_MARKETING_RED_H    IMAGE(@"d_marketing_red_h")
#define IMG_D_MARKETING_RED_F    IMAGE(@"d_marketing_red_f")
#define IMG_D_MARKETING_YELLOW   IMAGE(@"d_marketing_yellow")
#define IMG_D_MARKETING_YELLOW_H IMAGE(@"d_marketing_yellow_h")
#define IMG_D_MARKETING_YELLOW_F IMAGE(@"d_marketing_yellow_f")
#define IMG_D_MARKETING_GREEN    IMAGE(@"d_marketing_green")
#define IMG_D_MARKETING_GREEN_H  IMAGE(@"d_marketing_green_h")
#define IMG_D_MARKETING_GREEN_F  IMAGE(@"d_marketing_green_f")
#define IMG_D_MARKETING_GRAY     IMAGE(@"d_marketing_gray")
#define IMG_D_MARKETING_GRAY_H   IMAGE(@"d_marketing_gray_h")
#define IMG_D_MARKETING_GRAY_F   IMAGE(@"d_marketing_gray_f")

#define IMG_ACTION_DEL_SELECT    IMAGE(@"d_action_del_select")
#define IMG_ACTION_DEL           IMAGE(@"d_action_del")
#define IMG_FORWORD              IMAGE(@"forword")
#define IMG_FORWORD_SELECT       IMAGE(@"forword_select")
#define IMG_DELETE_GRAY          IMAGE(@"delete_gray")
#define IMG_DELETE_GRAY_SELECT   IMAGE(@"delete_gray_select")
#define IMG_NOT_SELECT           IMAGE(@"d_not_select")
#define IMG_SELECT               IMAGE(@"blue_select")
#define IMG_LINE                 IMAGE(@"d_line")
#define IMG_D_FINISH             IMAGE(@"d_finish")
#define IMG_D_HISTORY            IMAGE(@"d_history")
#define IMG_D_WAIT               IMAGE(@"d_wait")
#define IMG_TITLE_BG             IMAGE(@"d_title_bg")
#define IMG_D_OPERATION          IMAGE(@"d_operation")
#define IMG_D_LASTESTIME         IMAGE(@"d_lastestime")
#define IMG_D_SENDER             IMAGE(@"d_sender")
#define IMG_D_SENDER_GRAY        IMAGE(@"d_sender_gray")
#define IMG_D_CREATETIME         IMAGE(@"d_createtime")
#define IMG_D_CREATEIME_GRAY     IMAGE(@"d_createtime_gray")

//////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - 企信
//////////////////////////////////////////////////////////////////////////////////////////////////////

//通讯录
#define IMG_NO_PERSON                  IMAGE(@"icon_no_person")
#define IMG_LOG_HEADER                 IMAGE(@"blue_friendsIcon")
#define IMG_LOG_HEADER_GRAY            IMAGE(@"friendsIcon_gray")
#define IMG_MRLOG_HEADER               IMAGED(@"myIcon")
#define IMG_OPN                        IMAGE(@"msg_opn")
#define IMG_UNOPN                      IMAGE(@"msg_unopn")
#define IMG_ADDRESSBOOK_NEWFRIENDS     IMAGED(@"addressBook_newFriends")
#define IMG_PUBNUM_HEADER              IMAGED(@"pubNumIcon")

//聊天
#define IMG_AV_ON                      IMAGED(@"Action_Sheet_Cancel_New.png")
#define IMG_AV_OFF                     IMAGED(@"Action_Sheet_Normal_New.png")
#define IMG_AUDIO_DEFAULT              IMAGED(@"voice.png")
#define IMG_AUDIO_FOCUS                IMAGED(@"voice_HL.png")
#define IMG_EMOJI_DEFAULT              IMAGED(@"face.png")
#define IMG_EMOJI_FOCUS                IMAGED(@"face_HL.png")
#define IMG_TYPESELECTOR_DEFAULT       IMAGED(@"multiMedia.png")
#define IMG_TYPESELECTOR_FOCUS         IMAGED(@"multiMedia_HL.png")
#define IMG_KEYBOARD_DEFAULT           IMAGED(@"keyboard.png")
#define IMG_KEYBOARD_FOCUS             IMAGED(@"keyboard_HL.png")
#define IMG_PHOTO_ICON_DEFAULT         IMAGED(@"sharemore_pic.png")
#define IMG_PHOTO_ICON_FOCUS           IMAGED(@"icon_photo_focus.png")
#define IMG_VIDEO_ICON_DEFAULT         IMAGED(@"sharemore_videovoip.png")
#define IMG_VIDEO_ICON_FOCUS           IMAGED(@"icon_video_focus.png")
#define IMG_LOCATION_ICON_DEFAULT      IMAGED(@"sharemore_location.png")
#define IMG_LOCATION_ICON_FOCUS        IMAGED(@"icon_location_focus.png")
#define IMG_CAMERA_ICON_DEFAULT        IMAGED(@"sharemore_video.png")
#define IMG_CAMERA_ICON_FOCUS          IMAGED(@"icon_camera_focus.png")
#define IMG_VIDEO_PLAY_DEFAULT         IMAGED(@"icon_play_default.png")
#define IMG_VIDEO_PLAY_FOCUS           IMAGED(@"icon_play_focus.png")
#define IMG_COLLECTION_ICON_DEFAULT    IMAGED(@"sharemore_myfav.png")
#define IMG_VIDEOSTAR_ICON_DEFAULT     IMAGED(@"iocn_语音识别.png")
#define IMG_COLLECTION_ICON_FOCUS      IMAGED(@"icon_collection_focus.png")
#define IMG_SHARE_DEFAULT              IMAGED(@"share_no_image.png")
#define IMG_CHATIMAGE_DEFAULT          IMAGED(@"chatdefaultimage.png")

#define IMG_ORIGINIMAGE_NO             IMAGED(@"originImage_no.png")
#define IMG_ORIGINIMAGE_YES            IMAGED(@"originImage_yes.png")
#define IMG_KEYBOARDPUBNUM             IMAGED(@"keyboardPubNum.png")
#define IMG_MENUPUBNUM                 IMAGED(@"menuPubNum.png")
#define IMG_MORESECONDMENU             IMAGED(@"moreSecondPubNumMenu.png")

//rongzhitongVoIP Start
//#define IMG_AUDIOCALL_ICON_FOCUS        IMAGED(@"1.png")
//#define IMG_VIDEOCALL_ICON_FOCUS        IMAGED(@"2.png")
//#define IMG_SMALLVIDEO_ICON_FOCUS        IMAGED(@"icon_smallVideo_defaul.png")
#define IMG_AudioCallIncoming_ICON_FOCUS        IMAGED(@"CallIncoming.png")//音频拨打对方
#define IMG_AudioCallOutgoing_ICON_FOCUS        IMAGED(@"AudioCallOutgoing.png")//
#define IMG_VideoCallIncoming_ICON_FOCUS        IMAGED(@"VideoCallIncoming.png")//视频拨打对方
#define IMG_VideoCallOutgoing_ICON_FOCUS        IMAGED(@"VideoCallOutgoing.png")//视频对方拨打
#define IMG_VIDEOCALL_ICON_FOCUS        IMAGED(@"videoCall.png")//视频电话
#define IMG_VIDEOCALLMEETING_ICON_FOCUS        IMAGED(@"sharemore_群聊天.png")//视频电话
//rongzhitongVoIP End

//群管理
#define IMG_GROUP_DELETE               IMAGED(@"groupdelete.png")
#define IMG_GROUP_MANAGER_ADD          IMAGED(@"groupmanageAdd.png")
#define IMG_GROUP_MANAGER_REMOVE       IMAGED(@"groupmanageRemove.png")
#define IMG_GROUP_MANAGER_TAG          IMAGED(@"groupManagerTag.png")

//好友详情
#define IMG_FRIENDSDETAIL_SETREMARK    IMAGED(@"friendsDetial_setRemark.png")
#define IMG_FRIENDSDETAIL_CLEANRECORD  IMAGED(@"friendsDetial_cleanRecord.png")
#define IMG_FRIENDSDETAIL_VOICECHAT    IMAGED(@"friendsDetial_voiceChat.png")
#define IMG_FRIENDSDETAIL_VIDEOCHAT    IMAGED(@"friendsDetial_videoChat.png")
#define IMG_FRIENDSDETAIL_DELETEFRIEND IMAGED(@"friendsDetial_deleteFriend.png")

//添加动态
#define IMG_ADDTRENDS                  IMAGE(@"addTrends")
#define IMG_ADDTRENDS_DOWN             IMAGE(@"addTrends_down")
#define IMG_ADDTRENDSPIC               IMAGED(@"addTrendsPic.png")
#define IMG_PICKTHUMBNAIL_ON           IMAGED(@"thumbnail_on.png")
#define IMG_PICKTHUMBNAIL_OFF          IMAGED(@"thumbnail_off.png")
#define IMG_PHOTOBROWSER_DELETE        IMAGED(@"photoBrowser_delete.png")

//by  PerryMa
#define IMG_NO_CHAT                    IMAGED(@"icon_no_chat")
#define IMG_NO_CIRCLE                  IMAGED(@"icon_no_circle")
#define IMG_NO_GROUP                   IMAGED(@"icon_no_group")
#define IMG_ADDBUTTON                  IMAGED(@"addButton")
#define IMG_ADDBUTTON_DOWN             IMAGED(@"addButton_down")
#define IMG_ADDCONTACT                 IMAGED(@"new_addContact")
#define IMG_ADDCONTACT_DOWN            IMAGED(@"addContact_down")
#define IMG_ADDRESSBOOK                IMAGED(@"addressBook")
#define IMG_ADDRESSBOOK_DOWN           IMAGED(@"addressBook_down")
#define IMG_INCREASE                   IMAGED(@"increase")
#define IMG_INCREASE_DOWN              IMAGED(@"increase_down")

#define IMG_ADDRESSBOOK_CHAT           IMAGED(@"addressBook_chat")
#define IMG_GROUP_CHAT_TITLE           IMAGE(@"group_chat_title")
#define IMG_GROUP_CHAT                 IMAGED(@"blue_group_chat")
#define IMG_SEQUENCE_LETTER            IMAGED(@"sequence_letter")
#define IMG_ORGANIZATION_CONSTRUCT     IMAGED(@"organization_construct")
#define IMG_MYCIRCLE_CHAT              IMAGED(@"myCircle_chat")
#define IMG_SEARCH_CHAT                IMAGED(@"search_chat")
#define IMG_ICON_NOMBER                IMAGED(@"nomber1")
#define IMG_ICON_RED                   IMAGED(@"img_icon_red")
#define IMG_PRAISE_ICON                IMAGE(@"new_praise")

//链接分享、转发和收藏
#define IMG_LINK_COLLECT               IMAGED(@"link_collect")
#define IMG_LINK_SHARE                 IMAGED(@"link_share")
#define IMG_LINK_FORWARD               IMAGED(@"link_forward")


//我的动态   by fcx
#define IMG_PUBLISH_DYNAMIC            IMAGE(@"icon_publish_dynamic")
#define IMG_DYNAMIC_DEFAULT            IMAGED(@"icon_dynamic_default.png")
#define IMG_DYNAMIC_FOCUS              IMAGED(@"icon_dynamic_focus.png")

#define IMG_CHAT_MUTESIGN              IMAGED(@"mutesign.png")
#define IMG_CHAT_MUTESIGN_GRAY         IMAGED(@"mutesign_gray.png")
//打电话
//rongzhitongVoIP Start切换前后摄像头
#define IMG_HANDUP_MUTESIGN              IMAGED(@"挂断.png")
#define IMG_changeAudioOrVideo_MUTESIGN              IMAGED(@"切换到语音.png")
#define IMG_changeCamera_MUTESIGN              IMAGED(@"切换前后摄像头.png")
#define IMG_changeCameraPRE_MUTESIGN              IMAGED(@"切换前后摄像头pre.png")
#define IMG_MUTE_MUTESIGN              IMAGED(@"静音.png")
#define IMG_MUTEPRE_MUTESIGN              IMAGED(@"静音-pre.png")
#define IMG_jietong_MUTESIGN              IMAGED(@"接听.png")
#define IMG_SPEAKER_MUTESIGN              IMAGED(@"外放.png")
#define IMG_SPEAKERPRE_MUTESIGN              IMAGED(@"外放-选中-pre.png")


//rongzhitongVoIP End
//////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - 修改昵称页面背景
//////////////////////////////////////////////////////////////////////////////////////////////////////
#define IMG_UPDATE_NICKNAME IMAGE(@"update_nickname")
//////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark - 换肤 设置
//////////////////////////////////////////////////////////////////////////////////////////////////////

//设置账号管理图片
#define IMG_ACCOUNT_CHOOSE   IMAGED(@"account_choose")
#define IMG_ACCOUNT_PICT_BTN IMAGED(@"account_pict_btn")

#pragma mark - 意见反馈图片
//////////////////////////////////////////////////////////////////////////////////////////////////////
#define IMG_FK_ACTION1                  IMAGED(@"new_anction1")
#define IMG_FK_ACTION2                  IMAGED(@"new_anction2")
#define IMG_FK_ACTION3                  IMAGED(@"new_anction3")
#define IMG_FK_ANSWER                   IMAGED(@"anwer_service")
#define IMG_FK_QUERY                    IMAGE(@"blue_friendsIcon")
#define IMG_FK_TEXTINCOMING             IMAGED(@"bubble-square-incoming")
#define IMG_FK_TEXTOUTGOING             IMAGED(@"new_bubble-square-outgoing")
#define IMG_FK_LOAD                     IMAGED(@"load")
#define IMG_FK_LOADFAIL                 IMAGED(@"loadfail")
#define IMG_FK_BOTTOM_TEXTFIELD         IMAGED(@"chat_bottom_textfield")
#define IMG_FK_PLAY1                    IMAGED(@"setting_play1")
#define IMG_FK_PLAY2                    IMAGED(@"setting_play2")
#define IMG_FK_PLAY3                    IMAGED(@"setting_play3")
#define IMG_PICT_FOCUS                  IMAGED(@"pict_focus")

//发送位置图片
#define IMG_START_LOCATION_DEFAULT      IMAGED(@"start_location_default")
#define IMG_START_LOCATION_FOCUS        IMAGED(@"start_location_focus")

#define IMG_MAPTABLE_SELECT             IMAGED(@"map_tablecell_select")

#define IMG_PULL_FRESH                  IMAGE(@"down_fresh1")

//待办事宜图片
#define IMG_MARK_NOTE                   IMAGE(@"MarkImage_Note")
#define IMG_MARK_PICK_CLICK             IMAGE(@"MarkImage_PickClick")
#define IMG_MARK_PICK_NORMAL            IMAGE(@"MarkImage_PickNormal")
#define IMG_MARK_RADIO_BUTTON_CLICK     IMAGE(@"MarkImage_RadioButtonClick")
#define IMG_MARK_RADIO_BUTTON_NORMAL    IMAGE(@"MarkImage_RadioButtonNormal")

#define IMG_MARK_IMAGE_READ             IMAGED(@"MarkImage_Read")
#define IMG_MARK_IMAGE_FROM             IMAGED(@"MarkImage_From")
#define IMG_MARK_IMAGE_CLASS            IMAGED(@"MarkImage_Class")

//批量添加好友图片
#define IMG_ADDFRIEND_BATCH_DEFAULT     IMAGE(@"blue_friend_dire")
#define IMG_ADDFRIEND_BATCH_FOCUS       IMAGE(@"blue_friend_dire_pressed")
#define IMG_ADDFRIEND_EXPAND            IMAGED(@"friend_expand")
#define IMG_ADDFRIEND_CLOSE             IMAGED(@"friend_close")
#define IMG_ADDFRIEND_CHECKBOX_DEFAULT  IMAGED(@"friend_checkbox_default")
#define IMG_ADDFRIEND_CHECKBOX_SELECTED IMAGED(@"friend_checkbox_select")
#define IMG_ADDQUANTITYFRIEND           IMAGED(@"addquantityFriend")
#define IMG_BATCHFRIEND_ORGHEADER       IMAGED(@"orgHeadImage")

//扫一扫
#define IMG_SCANFRIENDS                 IMAGED(@"new_scanFriends")

//公众号图片
#define IMG_SERVERSIMAGE                                 IMAGED(@"ServersImage")
#define IMG_WEATHERIMAGE                                 IMAGED(@"WeatherImage")
#define IMG_PUBNUM_DEFAULT_HEAD                          IMAGED(@"pubNumHead")
#define IMG_PUBNUM_CONTENT_LINE                          IMAGED(@"pubnum_content_line")
#define IMG_PUBNUM_CHATVIEW_ADD_DEFAULT                  IMAGE(@"pubnum_chatview_rightbtn_default")
#define IMG_PUBNUM_CHATVIEW_ADD_FOCUS                    IMAGE(@"pubnum_chatview_rightbtn_focus")
#define IMG_CHATVIEW_RIGHTBTN_DEFAULT                    IMAGE(@"chatview_rightbtn_default")
#define IMG_CHATVIEW_RIGHTBTN_FOCUS                      IMAGE(@"chatview_rightbtn_focus")
#define IMG_GROUP_CHATVIEW_RIGHTBTN_DEFAULT              IMAGE(@"group_chatview_rightbtn_default")
#define IMG_GROUP_CHATVIEW_RIGHTBTN_FOCUS                IMAGE(@"group_chatview_rightbtn_focus")

#define IMG_WEBVIEW_CLEARALL                             IMAGED(@"webview_clearall")
#define IMG_WEBVIEW_PUBNUM_CANCELFOCUS                   IMAGED(@"webview_pubnum_cancelfocus")

//发送位置标准图（用于计算尺寸）
#define IMG_LOCATION_SAMPLE             IMAGED(@"location_sample")

//////////////////////////////////////////////////////////////////////////////////////////////////////
#define IMG_EXPRESS_MORE            IMAGED(@"expressAppMore")
