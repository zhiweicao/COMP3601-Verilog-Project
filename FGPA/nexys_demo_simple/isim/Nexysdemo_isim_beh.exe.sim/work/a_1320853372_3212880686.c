/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "//vmware-host/Shared Folders/home/comp3601/nexys_demo_simple/beatsHurdleCalculator.vhd";
extern char *IEEE_P_3620187407;

unsigned char ieee_p_3620187407_sub_1742983514_3965413181(char *, char *, char *, char *, char *);
char *ieee_p_3620187407_sub_436279890_3965413181(char *, char *, char *, char *, int );


static void work_a_1320853372_3212880686_p_0(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(51, ng0);

LAB3:    t1 = (t0 + 2152U);
    t2 = *((char **)t1);
    t1 = (t0 + 4136);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 32U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 4040);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_1320853372_3212880686_p_1(char *t0)
{
    char t13[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    unsigned char t10;
    unsigned char t11;
    unsigned char t12;
    char *t14;
    char *t15;
    char *t16;
    unsigned int t17;
    unsigned int t18;
    unsigned char t19;
    char *t20;
    char *t21;
    char *t22;
    char *t23;
    char *t24;

LAB0:    xsi_set_current_line(54, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t10 = (t4 == (unsigned char)3);
    if (t10 == 1)
        goto LAB7;

LAB8:    t3 = (unsigned char)0;

LAB9:    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 4056);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(55, ng0);
    t1 = (t0 + 4200);
    t5 = (t1 + 56U);
    t6 = *((char **)t5);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    *((unsigned char *)t8) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(56, ng0);
    t1 = (t0 + 7250);
    t5 = (t0 + 4264);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 32U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(57, ng0);
    t1 = (t0 + 7282);
    t5 = (t0 + 4328);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 8U);
    xsi_driver_first_trans_fast(t5);
    xsi_set_current_line(58, ng0);
    t1 = (t0 + 7290);
    t5 = (t0 + 4392);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 32U);
    xsi_driver_first_trans_fast(t5);
    goto LAB3;

LAB5:    xsi_set_current_line(61, ng0);
    t5 = (t0 + 2312U);
    t6 = *((char **)t5);
    t5 = (t0 + 7112U);
    t7 = (t0 + 1512U);
    t8 = *((char **)t7);
    t7 = (t0 + 7048U);
    t12 = ieee_p_3620187407_sub_1742983514_3965413181(IEEE_P_3620187407, t6, t5, t8, t7);
    if (t12 != 0)
        goto LAB10;

LAB12:    xsi_set_current_line(70, ng0);
    t1 = (t0 + 4200);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t1);

LAB11:    goto LAB3;

LAB7:    t1 = (t0 + 992U);
    t11 = xsi_signal_has_event(t1);
    t3 = t11;
    goto LAB9;

LAB10:    xsi_set_current_line(62, ng0);
    t9 = (t0 + 2312U);
    t14 = *((char **)t9);
    t9 = (t0 + 7112U);
    t15 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t13, t14, t9, 1);
    t16 = (t13 + 12U);
    t17 = *((unsigned int *)t16);
    t18 = (1U * t17);
    t19 = (32U != t18);
    if (t19 == 1)
        goto LAB13;

LAB14:    t20 = (t0 + 4264);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    t23 = (t22 + 56U);
    t24 = *((char **)t23);
    memcpy(t24, t15, 32U);
    xsi_driver_first_trans_fast(t20);
    xsi_set_current_line(63, ng0);
    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t1 = (t0 + 7080U);
    t5 = (t0 + 1352U);
    t6 = *((char **)t5);
    t5 = (t0 + 7032U);
    t3 = ieee_p_3620187407_sub_1742983514_3965413181(IEEE_P_3620187407, t2, t1, t6, t5);
    if (t3 != 0)
        goto LAB15;

LAB17:    xsi_set_current_line(66, ng0);
    t1 = (t0 + 2152U);
    t2 = *((char **)t1);
    t1 = (t0 + 7096U);
    t5 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t13, t2, t1, 1);
    t6 = (t13 + 12U);
    t17 = *((unsigned int *)t6);
    t18 = (1U * t17);
    t3 = (32U != t18);
    if (t3 == 1)
        goto LAB20;

LAB21:    t7 = (t0 + 4392);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t14 = (t9 + 56U);
    t15 = *((char **)t14);
    memcpy(t15, t5, 32U);
    xsi_driver_first_trans_fast(t7);
    xsi_set_current_line(67, ng0);
    t1 = (t0 + 7322);
    t5 = (t0 + 4328);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 8U);
    xsi_driver_first_trans_fast(t5);

LAB16:    goto LAB11;

LAB13:    xsi_size_not_matching(32U, t18, 0);
    goto LAB14;

LAB15:    xsi_set_current_line(64, ng0);
    t7 = (t0 + 1992U);
    t8 = *((char **)t7);
    t7 = (t0 + 7080U);
    t9 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t13, t8, t7, 1);
    t14 = (t13 + 12U);
    t17 = *((unsigned int *)t14);
    t18 = (1U * t17);
    t4 = (8U != t18);
    if (t4 == 1)
        goto LAB18;

LAB19:    t15 = (t0 + 4328);
    t16 = (t15 + 56U);
    t20 = *((char **)t16);
    t21 = (t20 + 56U);
    t22 = *((char **)t21);
    memcpy(t22, t9, 8U);
    xsi_driver_first_trans_fast(t15);
    goto LAB16;

LAB18:    xsi_size_not_matching(8U, t18, 0);
    goto LAB19;

LAB20:    xsi_size_not_matching(32U, t18, 0);
    goto LAB21;

}


extern void work_a_1320853372_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1320853372_3212880686_p_0,(void *)work_a_1320853372_3212880686_p_1};
	xsi_register_didat("work_a_1320853372_3212880686", "isim/Nexysdemo_isim_beh.exe.sim/work/a_1320853372_3212880686.didat");
	xsi_register_executes(pe);
}
