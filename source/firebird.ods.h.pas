unit firebird.ods.h;
interface(*
 * PROGRAM:  JRD Access Method
 * MODULE:    ods.h
 * DESCRIPTION:  On disk structure definitions
 *
 * The contents of this file are subject to the Interbase Public
 * License Version 1.0 (the "License"); you may not use this file
 * except in compliance with the License. You may obtain a copy
 * of the License at http://www.Inprise.com/IPL.html
 *
 * Software distributed under the License is distributed on an
 * "AS IS" basis, WITHOUT WARRANTY OF ANY KIND, either express
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
 * 2000.11.29 Patrick J. P. Griffin: fixed bug SF #116733
 * Add typedef struct gpg to properly document the layout of the generator page
 * 2002.08.26 Dmitry Yemanov: minor ODS change (new indices on system tables)
 *
 * 2002.10.29 Sean Leyne - Removed obsolete "Netware" port
 *
 * 2002.10.30 Sean Leyne - Removed support for obsolete "PC_PLATFORM" define
 *
 *)
const ODS_VERSION8  = 8;   // new btree structure to support pc semantics
const ODS_VERSION9  = 9;   // btree leaf pages are always propagated up
const ODS_VERSION10 = 10;  // V6.0 features. SQL delimited idetifier,
                           // SQLDATE, and 64-bit exact numeric type
const ODS_VERSION11 = 11;  // Firebird 2.x features
const ODS_VERSION12 = 12;  // Firebird 3.x features

function ENCODE_ODS(Major, Minor: UInt16): UInt16; inline;

const ODS_8_0       = ODS_VERSION8 shl 4 + 0;
const ODS_8_1       = ODS_VERSION8 shl 4 + 1;
const ODS_9_0       = ODS_VERSION9 shl 4 + 0;
const ODS_9_1       = ODS_VERSION9 shl 4 + 1;
const ODS_10_0      = ODS_VERSION10 shl 4 + 0;
const ODS_10_1      = ODS_VERSION10 shl 4 + 1;
const ODS_11_0      = ODS_VERSION11 shl 4 + 0;
const ODS_11_1      = ODS_VERSION11 shl 4 + 1;
const ODS_11_2      = ODS_VERSION11 shl 4 + 2;
const ODS_12_0      = ODS_VERSION12 shl 4 + 0;

type
  pag = record
    pag_type: Byte;
    pag_flags: Byte;
    pag_reserved: Word;        // not used but anyway present because of alignment rules
    pag_generation: Cardinal;
    pag_scn: Cardinal;
    pag_pageno: Cardinal;      // for validation
  end;

  header_page = record
    hdr_header: pag;
    hdr_page_size: Word;              // Page size of database
    hdr_ods_version: Word;            // Version of on-disk structure
    hdr_PAGES: Cardinal;              // Page number of PAGES relation
    hdr_next_page: Cardinal;          // Page number of next hdr page
    hdr_oldest_transaction: Cardinal; // Oldest interesting transaction
    hdr_oldest_active: Cardinal;      // Oldest transaction thought active
    hdr_next_transaction: Cardinal;   // Next transaction id
    hdr_sequence: Word;               // sequence number of file
    hdr_flags: Word;                  // Flag settings, see below
    hdr_creation_date: array[0..1] of Integer; // Date/time of creation
    hdr_attachment_id: Cardinal;      // Next attachment id
    hdr_shadow_count: Integer;        // Event count for shadow synchronization
    hdr_cpu: Byte;                    // CPU database was created on
    hdr_os: Byte;                     // OS database was created under
    hdr_cc: Byte;                     // Compiler of engine on which database was created
    hdr_compatibility_flags: Byte;    // Cross-platform database transfer compatibility flags
    hdr_ods_minor: Word;              // Update version of ODS
    hdr_end: Word;                    // offset of HDR_end in page
    hdr_page_buffers: Cardinal;       // Page buffers for database cache
    hdr_oldest_snapshot: Cardinal;    // Oldest snapshot of active transactions
    hdr_backup_pages: Integer;        // The amount of pages in files locked for backup
    hdr_crypt_page: Cardinal;         // Page at which processing is in progress
    hdr_top_crypt: Cardinal;          // Last page to crypt
    hdr_crypt_plugin: array[0..31] of AnsiChar;  // Name of plugin used to crypt this DB
    hdr_att_high: Integer;            // High word of the next attachment counter
    hdr_tra_high: array[0..3] of Word;// High words of the transaction counters
    hdr_data: array[0..0] of Byte;    // Misc data
  end;

implementation

function ENCODE_ODS(Major, Minor: UInt16): UInt16;
begin
  Result := Major shl 4 + Minor;
end;

end.
