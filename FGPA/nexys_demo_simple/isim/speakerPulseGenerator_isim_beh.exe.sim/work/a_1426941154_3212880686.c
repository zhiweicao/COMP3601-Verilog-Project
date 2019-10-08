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
static const char *ng0 = "//vmware-host/Shared Folders/home/comp3601/nexys_demo_simple/clock2pulse.vhd";
extern char *IEEE_P_3620187407;

char *ieee_p_3620187407_sub_436279890_3965413181(char *, char *, char *, char *, int );


static void work_a_1426941154_3212880686_p_0(char *t0)
{
    char t22[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    unsigned char t5;
    char *t6;
    unsigned char t7;
    unsigned char t8;
    unsigned char t9;
    char *t10;
    char *t11;
    char *t12;
    char *t13;
    unsigned char t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    char *t21;
    unsigned int t23;
    unsigned int t24;
    int t25;
    unsigned int t26;

LAB0:    xsi_set_current_line(48, ng0);
    t1 = (t0 + 1352U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    xsi_set_current_line(59, ng0);
    t1 = (t0 + 3520);
    t2 = (t1 + 56U);
    t6 = *((char **)t2);
    t10 = (t6 + 56U);
    t11 = *((char **)t10);
    *((unsigned char *)t11) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(60, ng0);
    t1 = (t0 + 5752);
    t6 = (t0 + 3456);
    t10 = (t6 + 56U);
    t11 = *((char **)t10);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t1, 2U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(61, ng0);
    t1 = (t0 + 5754);
    t6 = (t0 + 3392);
    t10 = (t6 + 56U);
    t11 = *((char **)t10);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    memcpy(t13, t1, 32U);
    xsi_driver_first_trans_fast(t6);

LAB3:    t1 = (t0 + 3312);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(49, ng0);
    t1 = (t0 + 1032U);
    t6 = *((char **)t1);
    t7 = *((unsigned char *)t6);
    t8 = (t7 == (unsigned char)3);
    if (t8 == 1)
        goto LAB8;

LAB9:    t5 = (unsigned char)0;

LAB10:    if (t5 != 0)
        goto LAB5;

LAB7:
LAB6:    goto LAB3;

LAB5:    xsi_set_current_line(50, ng0);
    t10 = (t0 + 1672U);
    t11 = *((char **)t10);
    t10 = (t0 + 5612U);
    t12 = (t0 + 1192U);
    t13 = *((char **)t12);
    t12 = (t0 + 5596U);
    t14 = ieee_std_logic_unsigned_greater_stdv_stdv(IEEE_P_3620187407, t11, t10, t13, t12);
    if (t14 != 0)
        goto LAB11;

LAB13:    xsi_set_current_line(54, ng0);
    t1 = (t0 + 1672U);
    t2 = *((char **)t1);
    t1 = (t0 + 5612U);
    t6 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t22, t2, t1, 1);
    t10 = (t22 + 12U);
    t23 = *((unsigned int *)t10);
    t24 = (1U * t23);
    t3 = (32U != t24);
    if (t3 == 1)
        goto LAB16;

LAB17:    t11 = (t0 + 3392);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t15 = (t13 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t6, 32U);
    xsi_driver_first_trans_fast(t11);
    xsi_set_current_line(55, ng0);
    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t25 = (0 - 1);
    t23 = (t25 * -1);
    t24 = (1U * t23);
    t26 = (0 + t24);
    t1 = (t2 + t26);
    t3 = *((unsigned char *)t1);
    t6 = (t0 + 3520);
    t10 = (t6 + 56U);
    t11 = *((char **)t10);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    *((unsigned char *)t13) = t3;
    xsi_driver_first_trans_fast_port(t6);

LAB12:    goto LAB6;

LAB8:    t1 = (t0 + 992U);
    t9 = xsi_signal_has_event(t1);
    t5 = t9;
    goto LAB10;

LAB11:    xsi_set_current_line(51, ng0);
    t15 = (t0 + 5720);
    t17 = (t0 + 3392);
    t18 = (t17 + 56U);
    t19 = *((char **)t18);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t15, 32U);
    xsi_driver_first_trans_fast(t17);
    xsi_set_current_line(52, ng0);
    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t1 = (t0 + 5628U);
    t6 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t22, t2, t1, 1);
    t10 = (t22 + 12U);
    t23 = *((unsigned int *)t10);
    t24 = (1U * t23);
    t3 = (2U != t24);
    if (t3 == 1)
        goto LAB14;

LAB15:    t11 = (t0 + 3456);
    t12 = (t11 + 56U);
    t13 = *((char **)t12);
    t15 = (t13 + 56U);
    t16 = *((char **)t15);
    memcpy(t16, t6, 2U);
    xsi_driver_first_trans_fast(t11);
    goto LAB12;

LAB14:    xsi_size_not_matching(2U, t24, 0);
    goto LAB15;

LAB16:    xsi_size_not_matching(32U, t24, 0);
    goto LAB17;

}


extern void work_a_1426941154_3212880686_init()
{
	static char *pe[] = {(void *)work_a_1426941154_3212880686_p_0};
	xsi_register_didat("work_a_1426941154_3212880686", "isim/speakerPulseGenerator_isim_beh.exe.sim/work/a_1426941154_3212880686.didat");
	xsi_register_executes(pe);
}
