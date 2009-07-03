unit firebird.client.debug;

interface

uses firebird.client;

type{$M+}
  TFirebirdClientDebugFactory = class(TInterfacedObject, IFirebirdLibraryDebugFactory)
  protected
    function Get(const aProcName: string; const aProc: pointer; const aParams:
        array of const; const aResult: longint): string;
  published
    function isc_attach_database(const aProcName: string; const aProc: pointer;
        const aParams: array of const; const aResult: longint): string;
    function isc_blob_info(const aProcName: string; const aProc: pointer; const
        aParams: array of const; const aResult: longint): string;
    function isc_close_blob(const aProcName: string; const aProc: pointer; const
        aParams: array of const; const aResult: longint): string;
    function isc_commit_transaction(const aProcName: string; const aProc: pointer;
        const aParams: array of const; const aResult: longint): string;
    function isc_create_blob2(const aProcName: string; const aProc: pointer; const
        aParams: array of const; const aResult: longint): string;
    function isc_decode_sql_date(const aProcName: string; const aProc: pointer;
        const aParams: array of const; const aResult: longint): string;
    function isc_decode_sql_time(const aProcName: string; const aProc: pointer;
        const aParams: array of const; const aResult: longint): string;
    function isc_decode_timestamp(const aProcName: string; const aProc: pointer;
        const aParams: array of const; const aResult: longint): string;
    function isc_detach_database(const aProcName: string; const aProc: pointer;
        const aParams: array of const; const aResult: longint): string;
    function isc_dsql_allocate_statement(const aProcName: string; const aProc:
        pointer; const aParams: array of const; const aResult: longint): string;
    function isc_dsql_alloc_statement2(const aProcName: string; const aProc:
        pointer; const aParams: array of const; const aResult: longint): string;
    function isc_dsql_describe(const aProcName: string; const aProc: pointer; const
        aParams: array of const; const aResult: longint): string;
    function isc_dsql_describe_bind(const aProcName: string; const aProc: pointer;
        const aParams: array of const; const aResult: longint): string;
    function isc_dsql_execute(const aProcName: string; const aProc: pointer; const
        aParams: array of const; const aResult: longint): string;
    function isc_dsql_execute_immediate(const aProcName: string; const aProc:
        pointer; const aParams: array of const; const aResult: longint): string;
    function isc_dsql_fetch(const aProcName: string; const aProc: pointer; const
        aParams: array of const; const aResult: longint): string;
    function isc_dsql_free_statement(const aProcName: string; const aProc: pointer;
        const aParams: array of const; const aResult: longint): string;
    function isc_dsql_prepare(const aProcName: string; const aProc: pointer; const
        aParams: array of const; const aResult: longint): string;
    function isc_dsql_sql_info(const aProcName: string; const aProc: pointer; const
        aParams: array of const; const aResult: longint): string;
    function isc_encode_sql_date(const aProcName: string; const aProc: pointer;
        const aParams: array of const; const aResult: longint): string;
    function isc_encode_sql_time(const aProcName: string; const aProc: pointer;
        const aParams: array of const; const aResult: longint): string;
    function isc_encode_timestamp(const aProcName: string; const aProc: pointer;
        const aParams: array of const; const aResult: longint): string;
    function isc_get_segment(const aProcName: string; const aProc: pointer; const
        aParams: array of const; const aResult: longint): string;
    function isc_open_blob(const aProcName: string; const aProc: pointer; const
        aParams: array of const; const aResult: longint): string;
    function isc_open_blob2(const aProcName: string; const aProc: pointer; const
        aParams: array of const; const aResult: longint): string;
    function isc_put_segment(const aProcName: string; const aProc: pointer; const
        aParams: array of const; const aResult: longint): string;
    function isc_rollback_transaction(const aProcName: string; const aProc:
        pointer; const aParams: array of const; const aResult: longint): string;
    function isc_start_multiple(const aProcName: string; const aProc: pointer;
        const aParams: array of const; const aResult: longint): string;
    function isc_vax_integer(const aProcName: string; const aProc: pointer; const
        aParams: array of const; const aResult: longint): string;
  end;

implementation

uses SysUtils,
     firebird.time.h, firebird.sqlda_pub.h, firebird.types_pub.h;

function TFirebirdClientDebugFactory.Get(const aProcName: string; const aProc:
    pointer; const aParams: array of const; const aResult: longint): string;
var pMethod: pointer;
    H: integer;
begin
  Result := aProcName;
  pMethod := Self.MethodAddress(aProcName);   // Find method in Message Class
  if Assigned(pMethod) then begin
    H := High(aParams);
    asm
      mov  eax,[aParams]        // 3rd argument: @aParams
      push eax
      mov  eax,[H]              // 4th argument: Highest index of dynamic array. Eg: High(aParams)
      push eax
      mov  eax,[aResult]        // 5th argument: aResult
      push eax
      mov  eax,[Result]         // 6th argument: @Result
      push eax
      mov  ecx,aProc            // 2nd argument: aProc
      mov  edx,[aProcName]      // 1st argument: aProcName
      mov  eax,[Self]           // address of self or class
      call pMethod              // call message method
    end;
  end;
end;

function TFirebirdClientDebugFactory.isc_attach_database(const aProcName:
    string; const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var P: ^Pointer;
begin
  P := aParams[3].VPointer;
  Result := Format('%s db_name: %s db_handle: %d', [aProcName, aParams[2].VPChar, integer(P^)]);
end;

function TFirebirdClientDebugFactory.isc_blob_info(const aProcName: string;
    const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var P: ^Pointer;
    Buf: PAnsiChar;
    i: integer;
begin
  P := aParams[1].VPointer;
  Buf := aParams[5].VPChar;
  Result := Format('%s blob_handle: %d ItemBufLen: %d ResultBufLen: %d ResultBuf: ', [aProcName, integer(P^), aParams[2].vInteger, aParams[4].vInteger]);
  for i := 0 to aParams[4].vInteger - 1 do
    Result := Result + IntToHex(Byte((Buf + i)^), 2) + ' ';
end;

function TFirebirdClientDebugFactory.isc_close_blob(const aProcName: string;
    const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var P: ^Pointer;
begin
  P := aParams[1].VPointer;
  Result := Format('%s blob_handle: %d', [aProcName, integer(P^)]);
end;

function TFirebirdClientDebugFactory.isc_commit_transaction(const aProcName:
    string; const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var P: ^Pointer;
begin
  P := aParams[1].VPointer;
  Result := Format('%s tr_handle: %d', [aProcName, integer(P^)]);
end;

function TFirebirdClientDebugFactory.isc_create_blob2(const aProcName: string;
    const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var P1, P2, P3: ^Pointer;
begin
  P1 := aParams[1].VPointer;
  P2 := aParams[2].VPointer;
  P3 := aParams[3].VPointer;
  Result := Format('%s db_handle: %d tr_handle: %d blob_handle: %d', [aProcName, integer(P1^), integer(P2^), integer(P3^)]);
end;

function TFirebirdClientDebugFactory.isc_decode_sql_date(const aProcName:
    string; const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var P: ^tm;
begin
  P := aParams[1].VPointer;
  Result := Format(
              '%s year: %d mon: %d mday: %d yday: %d weekday: %d isdst: %d',
              [aProcName, P.tm_year + 1900, P.tm_mon + 1, P.tm_mday, P.tm_yday, P.tm_wday, P.tm_isdst]);
end;

function TFirebirdClientDebugFactory.isc_decode_sql_time(const aProcName:
    string; const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var P: ^tm;
begin
  P := aParams[1].VPointer;
  Result := Format(
              '%s hour: %d min: %d sec: %d isdst: %d',
              [aProcName, P.tm_hour, P.tm_min, P.tm_sec, P.tm_isdst]);
end;

function TFirebirdClientDebugFactory.isc_decode_timestamp(const aProcName:
    string; const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var P: ^tm;
begin
  P := aParams[1].VPointer;
  Result := Format(
              '%s year: %d mon: %d mday: %d yday: %d weekday: %d hour: %d min: %d sec: %d isdst: %d',
              [aProcName, P.tm_year + 1900, P.tm_mon + 1, P.tm_mday, P.tm_yday, P.tm_wday, P.tm_hour, P.tm_min, P.tm_sec, P.tm_isdst]);
end;

function TFirebirdClientDebugFactory.isc_detach_database(const aProcName:
    string; const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var P: ^Pointer;
begin
  P := aParams[1].VPointer;
  Result := Format('%s db_handle: %d', [aProcName, integer(P^)]);
end;

function TFirebirdClientDebugFactory.isc_dsql_allocate_statement(const
    aProcName: string; const aProc: pointer; const aParams: array of const;
    const aResult: longint): string;
var P1, P2: ^Pointer;
begin
  P1 := aParams[1].VPointer;
  P2 := aParams[2].VPointer;
  Result := Format('%s db_handle: %d statement handle: %d', [aProcName, integer(P1^), integer(P2^)]);
end;

function TFirebirdClientDebugFactory.isc_dsql_alloc_statement2(const aProcName:
    string; const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var P1, P2: ^Pointer;
begin
  P1 := aParams[1].VPointer;
  P2 := aParams[2].VPointer;
  Result := Format('%s db_handle: %d statement handle: %d', [aProcName, integer(P1^), integer(P2^)]);
end;

function TFirebirdClientDebugFactory.isc_dsql_describe(const aProcName: string;
    const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var P1: ^Pointer;
    P2: PXSQLDA;
begin
  P1 := aParams[1].VPointer;
  P2 := aParams[3].VPointer;
  Result := Format(
              '%s statement handle: %d daVer: %d sqln: %d sqld: %d',
              [aProcName, integer(P1^), aParams[2].vInteger, P2.sqln, P2.sqld]);
end;

function TFirebirdClientDebugFactory.isc_dsql_describe_bind(const aProcName:
    string; const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var P1: ^Pointer;
    P2: PXSQLDA;
begin
  P1 := aParams[1].VPointer;
  P2 := aParams[3].VPointer;
  Result := Format(
              '%s statement handle: %d daVer: %d sqln: %d sqld: %d',
              [aProcName, integer(P1^), aParams[2].vInteger, P2.sqln, P2.sqld]);
end;

function TFirebirdClientDebugFactory.isc_dsql_execute(const aProcName: string;
    const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var P1, P2: ^pointer;
begin
  P1 := aParams[1].VPointer;
  P2 := aParams[2].VPointer;
  Result := Format(
              '%s transaction handle: %d statement handle: %d daVer: %d',
              [aProcName, integer(P1^), integer(P2^), aParams[3].vInteger]);
end;

function TFirebirdClientDebugFactory.isc_dsql_execute_immediate(const
    aProcName: string; const aProc: pointer; const aParams: array of const;
    const aResult: longint): string;
var P1, P2: ^pointer;
begin
  P1 := aParams[1].VPointer;
  P2 := aParams[2].VPointer;

  Result := Format('%s db_handle: %d transaction handle: %d %s', [aProcName, integer(P1^), integer(P2^), aParams[4].VPChar]);
end;

function TFirebirdClientDebugFactory.isc_dsql_fetch(const aProcName: string;
    const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var s: string;
begin
  case aResult of
    0: s := 'success';
    100: s := 'EOF';
    else s := 'Error';
  end;
  Result := Format('%s: %s', [aProcName, s]);
end;

function TFirebirdClientDebugFactory.isc_dsql_free_statement(const aProcName:
    string; const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var P: ^Pointer;
    s: string;
begin
  P := aParams[1].VPointer;
  case aParams[2].VInteger of
    DSQL_close: s := 'DSQL_close';
    DSQL_drop: s := 'DSQL_drop';
    DSQL_unprepare: s := 'DSQL_unprepare';
    else s := 'unknown';
  end;
  Result := Format('%s statement handle: %d Option: %s', [aProcName, integer(P^), s]);
end;

function TFirebirdClientDebugFactory.isc_dsql_prepare(const aProcName: string;
    const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var s: string;
begin
  SetString(S, aParams[4].VPChar, aParams[3].VInteger);
  Result := Format('%s SQLDialect: %d %s', [aProcName, aParams[5].VInteger, S]);
end;

function TFirebirdClientDebugFactory.isc_dsql_sql_info(const aProcName: string;
    const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var P: ^Pointer;
begin
  P := aParams[1].VPointer;
  Result := Format('%s statement handle: %d ', [aProcName, integer(P^)]);
end;

function TFirebirdClientDebugFactory.isc_encode_sql_date(const aProcName:
    string; const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var P: ^tm;
begin
  P := aParams[0].VPointer;
  Result := Format(
              '%s year: %d mon: %d mday: %d yday: %d weekday: %d isdst: %d',
              [aProcName, P.tm_year + 1900, P.tm_mon + 1, P.tm_mday, P.tm_yday, P.tm_wday, P.tm_isdst]);
end;

function TFirebirdClientDebugFactory.isc_encode_sql_time(const aProcName:
    string; const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var P: ^tm;
begin
  P := aParams[0].VPointer;
  Result := Format(
              '%s hour: %d min: %d sec: %d isdst: %d',
              [aProcName, P.tm_hour, P.tm_min, P.tm_sec, P.tm_isdst]);
end;

function TFirebirdClientDebugFactory.isc_encode_timestamp(const aProcName:
    string; const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var P: ^tm;
begin
  P := aParams[0].VPointer;
  Result := Format(
              '%s year: %d mon: %d mday: %d yday: %d weekday: %d hour: %d min: %d sec: %d isdst: %d',
              [aProcName, P.tm_year + 1900, P.tm_mon + 1, P.tm_mday, P.tm_yday, P.tm_wday, P.tm_hour, P.tm_min, P.tm_sec, P.tm_isdst]);
end;

function TFirebirdClientDebugFactory.isc_get_segment(const aProcName: string;
    const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var P: ^Pointer;
begin
  P := aParams[1].VPointer;
  Result := Format(
              '%s blob_handle: %d actual_seg_length: %d seg_buffer_length: %d',
              [aProcName, integer(P^), aParams[2].VInteger, aParams[3].VInteger]);
end;

function TFirebirdClientDebugFactory.isc_open_blob(const aProcName: string;
    const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var P1, P2, P3: ^Pointer;
    P4: PISC_QUAD;
begin
  P1 := aParams[1].VPointer;
  P2 := aParams[2].VPointer;
  P3 := aParams[3].VPointer;
  P4 := aParams[4].VPointer;
  Result := Format(
              '%s db_handle: %d tr_handle: %d blob_handle: %d, BlobID: %d %d',
              [aProcName, integer(P1^), integer(P2^), integer(P3^), P4^.gds_quad_high, P4^.gds_quad_low]);
end;

function TFirebirdClientDebugFactory.isc_open_blob2(const aProcName: string;
    const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var P1, P2, P3: ^Pointer;
    P4: PISC_QUAD;
begin
  P1 := aParams[1].VPointer;
  P2 := aParams[2].VPointer;
  P3 := aParams[3].VPointer;
  P4 := aParams[4].VPointer;
  Result := Format(
              '%s db_handle: %d tr_handle: %d blob_handle: %d, BlobID: %d %d, bpb_Length: %d ',
              [aProcName, integer(P1^), integer(P2^), integer(P3^), P4^.gds_quad_high, P4^.gds_quad_low, aParams[5].vInteger]);
end;

function TFirebirdClientDebugFactory.isc_put_segment(const aProcName: string;
    const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var P: ^Pointer;
begin
  P := aParams[1].VPointer;
  Result := Format(
              '%s blob_handle: %d seg_buffer_length: %d',
              [aProcName, integer(P^), aParams[2].VInteger]);
end;

function TFirebirdClientDebugFactory.isc_rollback_transaction(const aProcName:
    string; const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
begin
  Result := Format('%s tr_handle: %d', [aProcName, integer(aParams[1].VPointer)]);
end;

function TFirebirdClientDebugFactory.isc_start_multiple(const aProcName:
    string; const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var P: ^Pointer;
begin
  P := aParams[1].VPointer;
  Result := Format('%s tr_handle: %d', [aProcName, integer(P^)]);
end;

function TFirebirdClientDebugFactory.isc_vax_integer(const aProcName: string;
    const aProc: pointer; const aParams: array of const; const aResult:
    longint): string;
var P: PInteger;
begin
  P := aParams[0].VPointer;
  Result := Format('%s buffer: %d length: %d', [aProcName, P^, aParams[1].vInteger]);
end;

end.
