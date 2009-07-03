unit firebird.blr.h;

interface

(*
 *        PROGRAM:        C preprocessor
 *        MODULE:                blr.h
 *        DESCRIPTION:        BLR constants
 *
 * The contents of this filename are subject to the Interbase Public
 * License Version 1.0 (the 'License'); you may not use this filename
 * except in compliance with the License. You may obtain a copy
 * of the License at http://www.Inprise.com/IPL.html
 *
 * Software distributed under the License is distributed on an
 * 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, either express
 * or implied. See the License for the specific language governing
 * rights and limitations under the License.
 *
 * The Original Code was created by Inprise Corporation
 * and its predecessors. Portions created by Inprise Corporation are
 * Copyright (C) Inprise Corporation.
 *
 * All Rights Reserved.
 * Contributor(s): ______________________________________.
 *
 * Claudio Valderrama: 2001.6.18: Add blr_current_role.
 * 2002.09.28 Dmitry Yemanov: Reworked internal_info stuff, enhanced
 *                            exception handling in SPs/triggers,
 *                            implemented ROWS_AFFECTED system variable
 * 2002.10.21 Nickolay Samofatov: Added support for explicit pessimistic locks
 * 2002.10.29 Nickolay Samofatov: Added support for savepoints
 * 2003.10.05 Dmitry Yemanov: Added support for explicit cursors in PSQL
 * Adriano dos Santos Fernandes
 *)

//ifndef JRD_BLR_H
//const JRD_BLR_H =;

(*  WARNING: if you add a new BLR representing a data type, and the value
 *           is greater than the numerically greatest value which now
 *           represents a data ctype, you must change the define for
 *           DTYPE_BLR_MAX in jrd/align.h, and add the necessary entries
 *           to all the arrays in that filename.
 *)

const blr_text =           {(Byte)}14;
const blr_text2 =          {(Byte)}15;        (* added in 3.2 JPN *)
const blr_short =          {(Byte)}7;
const blr_long =           {(Byte)}8;
const blr_quad =           {(Byte)}9;
const blr_float =          {(Byte)}10;
const blr_double =         {(Byte)}27;
const blr_d_float =        {(Byte)}11;
const blr_timestamp =      {(Byte)}35;
const blr_varying =        {(Byte)}37;
const blr_varying2 =       {(Byte)}38;        (* added in 3.2 JPN *)
const blr_blob =           {(Word)}261;
const blr_cstring =        {(Byte)}40;
const blr_cstring2 =       {(Byte)}41;        (* added in 3.2 JPN *)
const blr_blob_id =        {(Byte)}45;        (* added from gds.h *)
const blr_sql_date =       {(Byte)}12;
const blr_sql_time =       {(Byte)}13;
const blr_int64 =          {(Byte)}16;
const blr_blob2 =          {(Byte)}17;
const blr_domain_name =    {(Byte)}18;
const blr_domain_name2 =   {(Byte)}19;
const blr_not_nullable =   {(Byte)}20;
const blr_column_name =    {(Byte)}21;
const blr_column_name2 =   {(Byte)}22;

// first sub parameter for blr_domain_name[2]
const blr_domain_type_of = {(Byte)}0;
const blr_domain_full =    {(Byte)}1;

(* Historical alias for pre V6 applications *)
const blr_date =           blr_timestamp;

const blr_inner =          {(Byte)}0;
const blr_left =           {(Byte)}1;
const blr_right =          {(Byte)}2;
const blr_full =           {(Byte)}3;

const blr_gds_code =       {(Byte)}0;
const blr_sql_code =       {(Byte)}1;
const blr_exception =      {(Byte)}2;
const blr_trigger_code =   {(Byte)}3;
const blr_default_code =   {(Byte)}4;
const blr_raise =          {(Byte)}5;
const blr_exception_msg =  {(Byte)}6;

const blr_version4 =       {(Byte)}4;
const blr_version5 =       {(Byte)}5;
const blr_eoc =            {(Byte)}76;
const blr_end =            {(Byte)}255;        (* note: defined as -1 in gds.h *)

const blr_assignment =     {(Byte)}1;
const blr_begin =          {(Byte)}2;
const blr_dcl_variable =   {(Byte)}3;        (* added from gds.h *)
const blr_message =        {(Byte)}4;
const blr_erase =          {(Byte)}5;
const blr_fetch =          {(Byte)}6;
const blr_for =            {(Byte)}7;
//const blr_if =             {(Byte)} then 8;
const blr_loop =           {(Byte)}9;
const blr_modify =         {(Byte)}10;
const blr_handler =        {(Byte)}11;
const blr_receive =        {(Byte)}12;
const blr_select =         {(Byte)}13;
const blr_send =           {(Byte)}14;
const blr_store =          {(Byte)}15;
const blr_label =          {(Byte)}17;
const blr_leave =          {(Byte)}18;
const blr_store2 =         {(Byte)}19;
const blr_post =           {(Byte)}20;
const blr_literal =        {(Byte)}21;
const blr_dbkey =          {(Byte)}22;
const blr_field =          {(Byte)}23;
const blr_fid =            {(Byte)}24;
const blr_parameter =      {(Byte)}25;
const blr_variable =       {(Byte)}26;
const blr_average =        {(Byte)}27;
const blr_count =          {(Byte)}28;
const blr_maximum =        {(Byte)}29;
const blr_minimum =        {(Byte)}30;
const blr_total =          {(Byte)}31;
(* count 2
const blr_count2 =                32;
*)
const blr_add =            {(Byte)}34;
const blr_subtract =       {(Byte)}35;
const blr_multiply =       {(Byte)}36;
const blr_divide =         {(Byte)}37;
const blr_negate =         {(Byte)}38;
const blr_concatenate =    {(Byte)}39;
const blr_substring =      {(Byte)}40;
const blr_parameter2 =     {(Byte)}41;
const blr_from =           {(Byte)}42;
const blr_via =            {(Byte)}43;
const blr_parameter2_old = {(Byte)}44;        (* Confusion *)
const blr_user_name =      {(Byte)}44;        (* added from gds.h *)
const blr_null =           {(Byte)}45;

const blr_equiv =          {(Byte)}46;
const blr_eql =            {(Byte)}47;
const blr_neq =            {(Byte)}48;
const blr_gtr =            {(Byte)}49;
const blr_geq =            {(Byte)}50;
const blr_lss =            {(Byte)}51;
const blr_leq =            {(Byte)}52;
const blr_containing =     {(Byte)}53;
const blr_matching =       {(Byte)}54;
const blr_starting =       {(Byte)}55;
const blr_between =        {(Byte)}56;
const blr_or =             {(Byte)}57;
const blr_and =            {(Byte)}58;
const blr_not =            {(Byte)}59;
const blr_any =            {(Byte)}60;
const blr_missing =        {(Byte)}61;
const blr_unique =         {(Byte)}62;
const blr_like =           {(Byte)}63;

//#define blr_stream              (unsigned char)65
//#define blr_set_index           (unsigned char)66

const blr_rse =            {(Byte)}67;
const blr_first =          {(Byte)}68;
const blr_project =        {(Byte)}69;
const blr_sort =           {(Byte)}70;
const blr_boolean =        {(Byte)}71;
const blr_ascending =      {(Byte)}72;
const blr_descending =     {(Byte)}73;
const blr_relation =       {(Byte)}74;
const blr_rid =            {(Byte)}75;
const blr_union =          {(Byte)}76;
const blr_map =            {(Byte)}77;
const blr_group_by =       {(Byte)}78;
const blr_aggregate =      {(Byte)}79;
const blr_join_type =      {(Byte)}80;

const blr_agg_count =      {(Byte)}83;
const blr_agg_max =        {(Byte)}84;
const blr_agg_min =        {(Byte)}85;
const blr_agg_total =      {(Byte)}86;
const blr_agg_average =    {(Byte)}87;
const blr_parameter3 =     {(Byte)}88;        (* same as Rdb definition *)
const blr_run_max =        {(Byte)}89;
const blr_run_min =        {(Byte)}90;
const blr_run_total =      {(Byte)}91;
const blr_run_average =    {(Byte)}92;
const blr_agg_count2 =     {(Byte)}93;
const blr_agg_count_distinct =   {(Byte)}94;
const blr_agg_total_distinct =   {(Byte)}95;
const blr_agg_average_distinct = {(Byte)}96;

const blr_function =       {(Byte: )}100;
const blr_gen_id =         {(Byte)}101;
const blr_prot_mask =      {(Byte)}102;
const blr_upcase =         {(Byte)}103;
const blr_lock_state =     {(Byte)}104;
//const blr_value_if =       {(Byte)} then 105;
const blr_matching2 =      {(Byte)}106;
const blr_index =          {(Byte)}107;
const blr_ansi_like =      {(Byte)}108;
//#define blr_bookmark                (unsigned char)109
//#define blr_crack                (unsigned char)110
//#define blr_force_crack                (unsigned char)111
const blr_seek =           {(Byte)}112;
//#define blr_find                (unsigned char)113

(* these indicate directions for blr_seek and blr_find *)

const blr_continue =       {(Byte)}0;
const blr_forward =        {(Byte)}1;
const blr_backward =       {(Byte)}2;
const blr_bof_forward =    {(Byte)}3;
const blr_eof_backward =   {(Byte)}4;

//#define blr_lock_relation         (unsigned char)114
//#define blr_lock_record                (unsigned char)115
//#define blr_set_bookmark         (unsigned char)116
//#define blr_get_bookmark         (unsigned char)117

const blr_run_count =      {(Byte)}118;        (* changed from 88 to avoid conflict with blr_parameter3 *)
const blr_rs_stream =      {(Byte)}119;
const blr_exec_proc =      {(Byte)}120;
//#define blr_begin_range         (unsigned char)121
//#define blr_end_range                 (unsigned char)122
//#define blr_delete_range         (unsigned char)123
const blr_procedure =      {(Byte: )}124;
const blr_pid =            {(Byte)}125;
const blr_exec_pid =       {(Byte)}126;
const blr_singular =       {(Byte)}127;
const blr_abort =          {(Byte)}128;
const blr_block =          {(Byte)}129;
//#define blr_error_handler        (Word Char)130

//#define blr_cast                (Word Char)131
//#define blr_release_lock        (unsigned char)132
//#define blr_release_locks        (unsigned char)133
//#define blr_start_savepoint        (Word Char)134
//#define blr_end_savepoint        (Word Char)135
//#define blr_find_dbkey                (unsigned char)136
//#define blr_range_relation        (unsigned char)137
//#define blr_delete_ranges        (unsigned char)138

//#define blr_plan                (Word Char)139        (* access plan items *)
//#define blr_merge                (Word Char)140
//#define blr_join                (Word Char)141
//#define blr_sequential                (Word Char)142
//#define blr_navigational        (Word Char)143
//#define blr_indices                (Word Char)144
//#define blr_retrieve                (Word Char)145

//#define blr_relation2                (Word Char)146
//#define blr_rid2                (Word Char)147
//#define blr_reset_stream        (unsigned char)148
//#define blr_release_bookmark        (unsigned char)149

//#define blr_set_generator       (Word Char)150

//#define blr_ansi_any                (Word Char)151   (* required for NULL handling *)
//#define blr_exists                (Word Char)152   (* required for NULL handling *)
//#define blr_cardinality                (unsigned char)153

//#define blr_record_version        (Word Char)154        (* get tid of record *)
//#define blr_stall                (Word Char)155        (* fake server stall *)

//#define blr_seek_no_warn        (unsigned char)156
//#define blr_find_dbkey_version        (unsigned char)157   /* find dbkey with record version */
//#define blr_ansi_all                (Word Char)158   (* required for NULL handling *)

//#define blr_extract                (unsigned char)159

(* sub parameters for blr_extract *)

//#define blr_extract_year                (unsigned char)0
//#define blr_extract_month                (unsigned char)1
//#define blr_extract_day                        (unsigned char)2
//#define blr_extract_hour                (unsigned char)3
//#define blr_extract_minute                (unsigned char)4
//#define blr_extract_second                (unsigned char)5
//#define blr_extract_weekday                (unsigned char)6
//#define blr_extract_yearday                (unsigned char)7
//#define blr_extract_millisecond        (unsigned char)8
//#define blr_extract_week                (unsigned char)9

//#define blr_current_date        (unsigned char)160
//#define blr_current_timestamp        (unsigned char)161
//#define blr_current_time        (unsigned char)162

(* These codes reuse BLR code space *)

//#define blr_post_arg                (unsigned char)163
//#define blr_exec_into                (unsigned char)164
//#define blr_user_savepoint        (unsigned char)165
//#define blr_dcl_cursor                (unsigned char)166
//#define blr_cursor_stmt                (unsigned char)167
//#define blr_current_timestamp2        (unsigned char)168
//#define blr_current_time2        (unsigned char)169
//#define blr_agg_list                (unsigned char)170
//#define blr_agg_list_distinct        (unsigned char)171
//#define blr_modify2                        (unsigned char)172

(* FB 1.0 specific BLR *)

//#define blr_current_role        (unsigned char)174
//#define blr_skip                (unsigned char)175

(* FB 1.5 specific BLR *)

//#define blr_exec_sql                (unsigned char)176
//#define blr_internal_info        (unsigned char)177
//#define blr_nullsfirst                (unsigned char)178
//#define blr_writelock                (unsigned char)179
//#define blr_nullslast       (unsigned char)180

(* FB 2.0 specific BLR *)

//#define blr_lowcase                        (unsigned char)181
//#define blr_strlen                        (unsigned char)182

(* sub parameter for blr_strlen *)
//#define blr_strlen_bit                (unsigned char)0
//#define blr_strlen_char                (unsigned char)1
//#define blr_strlen_octet        (unsigned char)2

//#define blr_trim                        (unsigned char)183

(* first sub parameter for blr_trim *)
//#define blr_trim_both                (unsigned char)0
//#define blr_trim_leading        (unsigned char)1
//#define blr_trim_trailing        (unsigned char)2

(* second sub parameter for blr_trim *)
//#define blr_trim_spaces                (unsigned char)0
//#define blr_trim_characters        (unsigned char)1

(* These codes are actions for user-defined savepoints *)

//#define blr_savepoint_set        (unsigned char)0
//#define blr_savepoint_release        (unsigned char)1
//#define blr_savepoint_undo        (unsigned char)2
//#define blr_savepoint_release_single        (unsigned char)3

(* These codes are actions for cursors *)

//#define blr_cursor_open                        (unsigned char)0
//#define blr_cursor_close                (unsigned char)1
//#define blr_cursor_fetch                (unsigned char)2

(* FB 2.1 specific BLR *)

//#define blr_init_variable        (unsigned char)184
//#define blr_recurse                        (unsigned char)185
//#define blr_sys_function        (char: unsigned)186

// FB 2.5 specific BLR

//#define blr_auto_trans                (unsigned char)187
//#define blr_similar                        (unsigned char)188
//#define blr_exec_stmt                (unsigned char)189

// subcodes of blr_exec_stmt
//#define blr_exec_stmt_inputs                (unsigned char) 1        // input parameters count
//#define blr_exec_stmt_outputs                (unsigned char) 2        // output parameters count
//#define blr_exec_stmt_sql                        (unsigned char) 3
//#define blr_exec_stmt_proc_block        (unsigned char) 4
//#define blr_exec_stmt_data_src                (unsigned char) 5
//#define blr_exec_stmt_user                        (unsigned char) 6
//#define blr_exec_stmt_pwd                        (unsigned char) 7
//#define blr_exec_stmt_tran                    (unsigned char) 8        // not implemented yet
//#define blr_exec_stmt_tran_clone        (unsigned char) 9        // make transaction parameters equal to current transaction
//#define blr_exec_stmt_privs                        (unsigned char) 10
//#define blr_exec_stmt_in_params                (unsigned char) 11        // not named input parameters
//#define blr_exec_stmt_in_params2        (unsigned char) 12        // named input parameters
//#define blr_exec_stmt_out_params        (unsigned char) 13        // output parameters

//#define blr_stmt_expr                                (unsigned char) 190
//#define blr_derived_expr                        (unsigned char) 191

//endif // JRD_BLR_H

implementation


end.
