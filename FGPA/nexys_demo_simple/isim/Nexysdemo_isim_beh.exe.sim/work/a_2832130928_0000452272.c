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
static const char *ng0 = "//vmware-host/Shared Folders/home/comp3601/nexys_demo_simple/blockRam.vhd";
extern char *IEEE_P_2592010699;
extern char *IEEE_P_3620187407;

unsigned char ieee_p_2592010699_sub_1744673427_503743352(char *, char *, unsigned int , unsigned int );
int ieee_p_3620187407_sub_514432868_3965413181(char *, char *, char *);


static void work_a_2832130928_0000452272_p_0(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    unsigned char t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    char *t11;
    unsigned char t12;
    unsigned char t13;
    int t14;
    int t15;
    unsigned int t16;
    unsigned int t17;
    unsigned int t18;
    char *t19;
    char *t20;
    char *t21;

LAB0:    xsi_set_current_line(22, ng0);
    t1 = (t0 + 1192U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)3);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 992U);
    t3 = ieee_p_2592010699_sub_1744673427_503743352(IEEE_P_2592010699, t1, 0U, 0U);
    if (t3 != 0)
        goto LAB11;

LAB12:
LAB3:    t1 = (t0 + 3632);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(23, ng0);
    t1 = (t0 + 7484);
    t6 = (16U != 16U);
    if (t6 == 1)
        goto LAB5;

LAB6:    t7 = (t0 + 3712);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t11 = *((char **)t10);
    memcpy(t11, t1, 16U);
    xsi_driver_first_trans_delta(t7, 1008U, 16U, 0LL);
    xsi_set_current_line(24, ng0);
    t1 = (t0 + 7500);
    t3 = (16U != 16U);
    if (t3 == 1)
        goto LAB7;

LAB8:    t5 = (t0 + 3712);
    t7 = (t5 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 16U);
    xsi_driver_first_trans_delta(t5, 992U, 16U, 0LL);
    xsi_set_current_line(25, ng0);
    t1 = (t0 + 7516);
    t3 = (16U != 16U);
    if (t3 == 1)
        goto LAB9;

LAB10:    t5 = (t0 + 3712);
    t7 = (t5 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 16U);
    xsi_driver_first_trans_delta(t5, 976U, 16U, 0LL);
    goto LAB3;

LAB5:    xsi_size_not_matching(16U, 16U, 0);
    goto LAB6;

LAB7:    xsi_size_not_matching(16U, 16U, 0);
    goto LAB8;

LAB9:    xsi_size_not_matching(16U, 16U, 0);
    goto LAB10;

LAB11:    xsi_set_current_line(51, ng0);
    t2 = (t0 + 1352U);
    t5 = *((char **)t2);
    t4 = *((unsigned char *)t5);
    t6 = (t4 == (unsigned char)3);
    if (t6 != 0)
        goto LAB13;

LAB15:
LAB14:    goto LAB3;

LAB13:    xsi_set_current_line(52, ng0);
    t2 = (t0 + 1512U);
    t7 = *((char **)t2);
    t12 = *((unsigned char *)t7);
    t13 = (t12 == (unsigned char)3);
    if (t13 != 0)
        goto LAB16;

LAB18:
LAB17:    xsi_set_current_line(55, ng0);
    t1 = (t0 + 2152U);
    t2 = *((char **)t1);
    t1 = (t0 + 1672U);
    t5 = *((char **)t1);
    t1 = (t0 + 6344U);
    t14 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t5, t1);
    t15 = (t14 - 63);
    t16 = (t15 * -1);
    xsi_vhdl_check_range_of_index(63, 0, -1, t14);
    t17 = (16U * t16);
    t18 = (0 + t17);
    t7 = (t2 + t18);
    t8 = (t0 + 3776);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    t11 = (t10 + 56U);
    t19 = *((char **)t11);
    memcpy(t19, t7, 16U);
    xsi_driver_first_trans_fast_port(t8);
    goto LAB14;

LAB16:    xsi_set_current_line(53, ng0);
    t2 = (t0 + 1832U);
    t8 = *((char **)t2);
    t2 = (t0 + 1672U);
    t9 = *((char **)t2);
    t2 = (t0 + 6344U);
    t14 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t9, t2);
    t15 = (t14 - 63);
    t16 = (t15 * -1);
    t17 = (16U * t16);
    t18 = (0U + t17);
    t10 = (t0 + 3712);
    t11 = (t10 + 56U);
    t19 = *((char **)t11);
    t20 = (t19 + 56U);
    t21 = *((char **)t20);
    memcpy(t21, t8, 16U);
    xsi_driver_first_trans_delta(t10, t18, 16U, 0LL);
    goto LAB17;

}


extern void work_a_2832130928_0000452272_init()
{
	static char *pe[] = {(void *)work_a_2832130928_0000452272_p_0};
	xsi_register_didat("work_a_2832130928_0000452272", "isim/Nexysdemo_isim_beh.exe.sim/work/a_2832130928_0000452272.didat");
	xsi_register_executes(pe);
}
