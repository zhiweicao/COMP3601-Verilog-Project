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

#include "xsi.h"

struct XSI_INFO xsi_info;

char *IEEE_P_2592010699;
char *STD_STANDARD;
char *IEEE_P_3499444699;
char *IEEE_P_3620187407;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    ieee_p_2592010699_init();
    ieee_p_3499444699_init();
    ieee_p_3620187407_init();
    work_a_3048328853_3212880686_init();
    work_a_1426941154_3212880686_init();
    work_a_3951477692_3212880686_init();
    work_a_2250642656_3212880686_init();
    work_a_1573351827_3212880686_init();
    work_a_0879381952_3212880686_init();
    work_a_3892522338_3212880686_init();
    work_a_1474961982_3212880686_init();
    work_a_2832130928_0000452272_init();
    work_a_0099815403_3212880686_init();
    work_a_2350714813_3212880686_init();
    work_a_2088231127_3212880686_init();
    work_a_1320853372_3212880686_init();
    work_a_2100066211_3212880686_init();
    work_a_3527397171_3212880686_init();
    work_a_1208337864_3212880686_init();
    work_a_2571160139_3212880686_init();
    work_a_0450304596_3212880686_init();


    xsi_register_tops("work_a_0450304596_3212880686");

    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    IEEE_P_3499444699 = xsi_get_engine_memory("ieee_p_3499444699");
    IEEE_P_3620187407 = xsi_get_engine_memory("ieee_p_3620187407");

    return xsi_run_simulation(argc, argv);

}
