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
static const char *ng0 = "//vmware-host/Shared Folders/home/comp3601/nexys_demo_simple/display.vhd";
extern char *IEEE_P_3620187407;

unsigned char ieee_p_3620187407_sub_4060537613_3965413181(char *, char *, char *, char *, char *);
char *ieee_p_3620187407_sub_436279890_3965413181(char *, char *, char *, char *, int );


static void work_a_1474961982_3212880686_p_0(char *t0)
{
    char t19[16];
    unsigned char t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    unsigned char t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    unsigned char t11;
    char *t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    unsigned int t20;
    unsigned int t21;

LAB0:    xsi_set_current_line(65, ng0);
    t2 = (t0 + 1032U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)3);
    if (t5 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 4000);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(66, ng0);
    t7 = (t0 + 1832U);
    t8 = *((char **)t7);
    t7 = (t0 + 6916U);
    t9 = (t0 + 2448U);
    t10 = *((char **)t9);
    t9 = (t0 + 6900U);
    t11 = ieee_p_3620187407_sub_4060537613_3965413181(IEEE_P_3620187407, t8, t7, t10, t9);
    if (t11 != 0)
        goto LAB8;

LAB10:    xsi_set_current_line(70, ng0);
    t2 = (t0 + 1832U);
    t3 = *((char **)t2);
    t2 = (t0 + 6916U);
    t7 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t19, t3, t2, 1);
    t8 = (t19 + 12U);
    t20 = *((unsigned int *)t8);
    t21 = (1U * t20);
    t1 = (17U != t21);
    if (t1 == 1)
        goto LAB13;

LAB14:    t9 = (t0 + 4096);
    t10 = (t9 + 56U);
    t12 = *((char **)t10);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t7, 17U);
    xsi_driver_first_trans_fast(t9);

LAB9:    goto LAB3;

LAB5:    t2 = (t0 + 992U);
    t6 = xsi_signal_has_event(t2);
    t1 = t6;
    goto LAB7;

LAB8:    xsi_set_current_line(67, ng0);
    t12 = (t0 + 7057);
    t14 = (t0 + 4096);
    t15 = (t14 + 56U);
    t16 = *((char **)t15);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    memcpy(t18, t12, 17U);
    xsi_driver_first_trans_fast(t14);
    xsi_set_current_line(68, ng0);
    t2 = (t0 + 1992U);
    t3 = *((char **)t2);
    t2 = (t0 + 6932U);
    t7 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t19, t3, t2, 1);
    t8 = (t19 + 12U);
    t20 = *((unsigned int *)t8);
    t21 = (1U * t20);
    t1 = (2U != t21);
    if (t1 == 1)
        goto LAB11;

LAB12:    t9 = (t0 + 4160);
    t10 = (t9 + 56U);
    t12 = *((char **)t10);
    t13 = (t12 + 56U);
    t14 = *((char **)t13);
    memcpy(t14, t7, 2U);
    xsi_driver_first_trans_fast(t9);
    goto LAB9;

LAB11:    xsi_size_not_matching(2U, t21, 0);
    goto LAB12;

LAB13:    xsi_size_not_matching(17U, t21, 0);
    goto LAB14;

}

static void work_a_1474961982_3212880686_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    int t4;
    char *t5;
    char *t6;
    int t7;
    char *t8;
    char *t9;
    int t10;
    char *t11;
    int t13;
    char *t14;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;

LAB0:    xsi_set_current_line(79, ng0);
    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t1 = (t0 + 7074);
    t4 = xsi_mem_cmp(t1, t2, 2U);
    if (t4 == 1)
        goto LAB3;

LAB8:    t5 = (t0 + 7076);
    t7 = xsi_mem_cmp(t5, t2, 2U);
    if (t7 == 1)
        goto LAB4;

LAB9:    t8 = (t0 + 7078);
    t10 = xsi_mem_cmp(t8, t2, 2U);
    if (t10 == 1)
        goto LAB5;

LAB10:    t11 = (t0 + 7080);
    t13 = xsi_mem_cmp(t11, t2, 2U);
    if (t13 == 1)
        goto LAB6;

LAB11:
LAB7:    xsi_set_current_line(93, ng0);
    t1 = (t0 + 7098);
    t3 = (t0 + 4224);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 4U);
    xsi_driver_first_trans_fast_port(t3);
    xsi_set_current_line(94, ng0);
    t1 = (t0 + 7102);
    t3 = (t0 + 4288);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 8U);
    xsi_driver_first_trans_fast_port(t3);

LAB2:    t1 = (t0 + 4016);
    *((int *)t1) = 1;

LAB1:    return;
LAB3:    xsi_set_current_line(81, ng0);
    t14 = (t0 + 7082);
    t16 = (t0 + 4224);
    t17 = (t16 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t14, 4U);
    xsi_driver_first_trans_fast_port(t16);
    xsi_set_current_line(82, ng0);
    t1 = (t0 + 2152U);
    t2 = *((char **)t1);
    t21 = (31 - 7);
    t22 = (t21 * 1U);
    t23 = (0 + t22);
    t1 = (t2 + t23);
    t3 = (t0 + 4288);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 8U);
    xsi_driver_first_trans_fast_port(t3);
    goto LAB2;

LAB4:    xsi_set_current_line(84, ng0);
    t1 = (t0 + 7086);
    t3 = (t0 + 4224);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 4U);
    xsi_driver_first_trans_fast_port(t3);
    xsi_set_current_line(85, ng0);
    t1 = (t0 + 2152U);
    t2 = *((char **)t1);
    t21 = (31 - 15);
    t22 = (t21 * 1U);
    t23 = (0 + t22);
    t1 = (t2 + t23);
    t3 = (t0 + 4288);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 8U);
    xsi_driver_first_trans_fast_port(t3);
    goto LAB2;

LAB5:    xsi_set_current_line(87, ng0);
    t1 = (t0 + 7090);
    t3 = (t0 + 4224);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 4U);
    xsi_driver_first_trans_fast_port(t3);
    xsi_set_current_line(88, ng0);
    t1 = (t0 + 2152U);
    t2 = *((char **)t1);
    t21 = (31 - 23);
    t22 = (t21 * 1U);
    t23 = (0 + t22);
    t1 = (t2 + t23);
    t3 = (t0 + 4288);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 8U);
    xsi_driver_first_trans_fast_port(t3);
    goto LAB2;

LAB6:    xsi_set_current_line(90, ng0);
    t1 = (t0 + 7094);
    t3 = (t0 + 4224);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 4U);
    xsi_driver_first_trans_fast_port(t3);
    xsi_set_current_line(91, ng0);
    t1 = (t0 + 2152U);
    t2 = *((char **)t1);
    t21 = (31 - 31);
    t22 = (t21 * 1U);
    t23 = (0 + t22);
    t1 = (t2 + t23);
    t3 = (t0 + 4288);
    t5 = (t3 + 56U);
    t6 = *((char **)t5);
    t8 = (t6 + 56U);
    t9 = *((char **)t8);
    memcpy(t9, t1, 8U);
    xsi_driver_first_trans_fast_port(t3);
    goto LAB2;

LAB12:;
}


extern void work_a_1474961982_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1474961982_3212880686_p_0,(void *)work_a_1474961982_3212880686_p_1};
	xsi_register_didat("work_a_1474961982_3212880686", "isim/BeatTest_isim_beh.exe.sim/work/a_1474961982_3212880686.didat");
	xsi_register_executes(pe);
}
