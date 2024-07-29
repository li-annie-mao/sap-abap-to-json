*----------------------------------------------------------------------*
*       CLASS Z_UI2_JSON DEFINITION
*----------------------------------------------------------------------*
*
*----------------------------------------------------------------------*
class Z_UI2_JSON definition
  public
  create public .

public section.
  type-pools ABAP .
  class CL_ABAP_TSTMP definition load .
  class CX_SY_CONVERSION_ERROR definition load .

  types JSON type STRING .
  types:
    BEGIN OF name_mapping,
        abap TYPE abap_compname,
        json TYPE string,
      END OF name_mapping .
  types:
    name_mappings    TYPE HASHED TABLE OF name_mapping WITH UNIQUE KEY abap .
  types:
    ref_tab          TYPE STANDARD TABLE OF REF TO data WITH DEFAULT KEY .
  types BOOL type CHAR1 .
  types TRIBOOL type CHAR1 .
  types PRETTY_NAME_MODE type CHAR1 .

  constants:
    BEGIN OF pretty_mode,
        none          TYPE char1  VALUE ``,
        low_case      TYPE char1  VALUE 'L',
        camel_case    TYPE char1  VALUE 'X',
        extended      TYPE char1  VALUE 'Y',
        user          TYPE char1  VALUE 'U',
        user_low_case TYPE char1  VALUE 'C',
      END OF  pretty_mode .
  constants:
    BEGIN OF c_bool,
        true  TYPE bool  VALUE 'X',
        false TYPE bool  VALUE '',
      END OF  c_bool .
  constants:
    BEGIN OF c_tribool,
        true      TYPE tribool  VALUE c_bool-true,
        false     TYPE tribool  VALUE '-',
        undefined TYPE tribool  VALUE ``,
      END OF  c_tribool .
  class-data SV_WHITE_SPACE type STRING read-only .
  constants MC_KEY_SEPARATOR type STRING value `-` ##NO_TEXT.
  class-data MC_BOOL_TYPES type STRING read-only value `\TYPE-POOL=ABAP\TYPE=ABAP_BOOL\TYPE=BOOLEAN\TYPE=BOOLE_D\TYPE=XFELD\TYPE=XSDBOOLEAN\TYPE=WDY_BOOLEAN` ##NO_TEXT.
  class-data MC_BOOL_3STATE type STRING read-only value `\TYPE=BOOLEAN` ##NO_TEXT.
  constants VERSION type I value 19 ##NO_TEXT.
  class-data MC_JSON_TYPE type STRING read-only .

  class-methods CLASS_CONSTRUCTOR .
  class-methods STRING_TO_XSTRING
    importing
      !IN type STRING
    changing
      value(OUT) type ANY .
  class-methods XSTRING_TO_STRING
    importing
      !IN type ANY
    returning
      value(OUT) type STRING .
  class-methods RAW_TO_STRING
    importing
      !IV_XSTRING type XSTRING
      !IV_ENCODING type ABAP_ENCODING optional
    returning
      value(RV_STRING) type STRING .
  class-methods STRING_TO_RAW
    importing
      !IV_STRING type STRING
      !IV_ENCODING type ABAP_ENCODING optional
    returning
      value(RV_XSTRING) type XSTRING .
  class-methods DUMP
    importing
      !DATA type DATA
      !COMPRESS type BOOL default C_BOOL-FALSE
      !TYPE_DESCR type ref to CL_ABAP_TYPEDESCR optional
      !PRETTY_NAME type PRETTY_NAME_MODE default PRETTY_MODE-NONE
      !ASSOC_ARRAYS type BOOL default C_BOOL-FALSE
      !TS_AS_ISO8601 type BOOL default C_BOOL-FALSE
    returning
      value(R_JSON) type JSON .
  class-methods DESERIALIZE
    importing
      !JSON type JSON optional
      !JSONX type XSTRING optional
      !PRETTY_NAME type PRETTY_NAME_MODE default PRETTY_MODE-NONE
      !ASSOC_ARRAYS type BOOL default C_BOOL-FALSE
      !ASSOC_ARRAYS_OPT type BOOL default C_BOOL-FALSE
      !NAME_MAPPINGS type NAME_MAPPINGS optional
      !CONVERSION_EXITS type BOOL default C_BOOL-FALSE
      !HEX_AS_BASE64 type BOOL default C_BOOL-TRUE
      !GEN_OPTIMIZE type BOOL default C_BOOL-FALSE
    changing
      !DATA type DATA .
  class-methods SERIALIZE
    importing
      !DATA type DATA
      !COMPRESS type BOOL default C_BOOL-FALSE
      !NAME type STRING optional
      !PRETTY_NAME type PRETTY_NAME_MODE default PRETTY_MODE-NONE
      !TYPE_DESCR type ref to CL_ABAP_TYPEDESCR optional
      !ASSOC_ARRAYS type BOOL default C_BOOL-FALSE
      !TS_AS_ISO8601 type BOOL default C_BOOL-FALSE
      !EXPAND_INCLUDES type BOOL default C_BOOL-TRUE
      !ASSOC_ARRAYS_OPT type BOOL default C_BOOL-FALSE
      !NUMC_AS_STRING type BOOL default C_BOOL-FALSE
      !NAME_MAPPINGS type NAME_MAPPINGS optional
      !CONVERSION_EXITS type BOOL default C_BOOL-FALSE
      !FORMAT_OUTPUT type BOOL default C_BOOL-FALSE
      !HEX_AS_BASE64 type BOOL default C_BOOL-TRUE
    returning
      value(R_JSON) type JSON .
  methods DESERIALIZE_INT
    importing
      !JSON type JSON optional
      !JSONX type XSTRING optional
    changing
      !DATA type DATA
    raising
      CX_SY_MOVE_CAST_ERROR .
  class-methods GENERATE
    importing
      !JSON type JSON optional
      !PRETTY_NAME type PRETTY_NAME_MODE default PRETTY_MODE-NONE
      !OPTIMIZE type BOOL default C_BOOL-FALSE
      !NAME_MAPPINGS type NAME_MAPPINGS optional
      !JSONX type XSTRING optional
    preferred parameter JSON
    returning
      value(RR_DATA) type ref to DATA .
  methods SERIALIZE_INT
    importing
      !DATA type DATA
      !NAME type STRING optional
      !TYPE_DESCR type ref to CL_ABAP_TYPEDESCR optional
    returning
      value(R_JSON) type JSON .
  methods GENERATE_INT
    importing
      !JSON type JSON
      value(LENGTH) type I optional
    changing
      !DATA type ref to DATA
      !OFFSET type I default 0
    raising
      CX_SY_MOVE_CAST_ERROR .
  methods CONSTRUCTOR
    importing
      !COMPRESS type BOOL default C_BOOL-FALSE
      !PRETTY_NAME type PRETTY_NAME_MODE default PRETTY_MODE-NONE
      !ASSOC_ARRAYS type BOOL default C_BOOL-FALSE
      !TS_AS_ISO8601 type BOOL default C_BOOL-FALSE
      !EXPAND_INCLUDES type BOOL default C_BOOL-TRUE
      !ASSOC_ARRAYS_OPT type BOOL default C_BOOL-FALSE
      !STRICT_MODE type BOOL default C_BOOL-FALSE
      !NUMC_AS_STRING type BOOL default C_BOOL-FALSE
      !NAME_MAPPINGS type NAME_MAPPINGS optional
      !CONVERSION_EXITS type BOOL default C_BOOL-FALSE
      !FORMAT_OUTPUT type BOOL default C_BOOL-FALSE
      !HEX_AS_BASE64 type BOOL default C_BOOL-TRUE
      !GEN_OPTIMIZE type BOOL default C_BOOL-FALSE
      !BOOL_TYPES type STRING default MC_BOOL_TYPES
      !BOOL_3STATE type STRING default MC_BOOL_3STATE
      !INITIAL_TS type STRING default `""`
      !INITIAL_DATE type STRING default `""`
      !INITIAL_TIME type STRING default `""`
      !TIME_ZONE like SY-ZONLO default 'UTC' .
  class-methods BOOL_TO_TRIBOOL
    importing
      !IV_BOOL type BOOL
    returning
      value(RV_TRIBOOL) type TRIBOOL .
  class-methods TRIBOOL_TO_BOOL
    importing
      !IV_TRIBOOL type TRIBOOL
    returning
      value(RV_BOOL) type BOOL .
  PROTECTED SECTION.

    TYPES:
      BEGIN OF t_s_field_cache,
        name         TYPE string,
        type         TYPE REF TO cl_abap_datadescr,
        elem_type    TYPE REF TO cl_abap_elemdescr,
        typekind     TYPE abap_typekind,
        convexit_out TYPE string,
        convexit_in  TYPE string,
        value        TYPE REF TO data,
      END OF t_s_field_cache .
    TYPES:
      BEGIN OF t_s_symbol,
        header       TYPE string,
        compressable TYPE abap_bool,
        read_only    TYPE abap_bool.
        INCLUDE TYPE t_s_field_cache.
    TYPES: END OF t_s_symbol .
    TYPES:
      t_t_symbol TYPE STANDARD TABLE OF t_s_symbol WITH DEFAULT KEY .
    TYPES:
      t_t_field_cache  TYPE HASHED TABLE OF t_s_field_cache WITH UNIQUE KEY name .
    TYPES:
      name_mappings_ex TYPE HASHED TABLE OF name_mapping WITH UNIQUE KEY json .
    TYPES:
      BEGIN OF t_s_name_json,
        name  TYPE string,
        value TYPE json,
      END OF t_s_name_json.
    TYPES:
      t_t_name_json TYPE SORTED TABLE OF t_s_name_json WITH UNIQUE KEY name.
    TYPES:
      BEGIN OF t_s_name_value.
        INCLUDE TYPE t_s_name_json.
    TYPES: data TYPE REF TO data,
      END OF t_s_name_value .
    TYPES:
      t_t_name_value TYPE SORTED TABLE OF t_s_name_value WITH UNIQUE KEY name .
    TYPES:
      t_t_json TYPE STANDARD TABLE OF json WITH DEFAULT KEY .
    TYPES:
      BEGIN OF t_s_struct_type,
        keys TYPE string,
        type TYPE REF TO cl_abap_datadescr,
      END OF t_s_struct_type .
    TYPES:
      t_t_struct_type TYPE SORTED TABLE OF t_s_struct_type WITH UNIQUE KEY keys .
    TYPES:
      BEGIN OF t_s_struct_cache_res,
        data    TYPE REF TO data,
        symbols TYPE t_t_symbol,
      END OF t_s_struct_cache_res .
    TYPES:
      BEGIN OF t_s_struct_cache,
        type_descr      TYPE REF TO cl_abap_structdescr,
        include_aliases	TYPE abap_bool,
        level           TYPE i,
        result          TYPE t_s_struct_cache_res,
      END OF t_s_struct_cache .
    TYPES:
      t_t_struct_cache TYPE HASHED TABLE OF t_s_struct_cache WITH UNIQUE KEY type_descr include_aliases level .

    DATA mv_bool_types TYPE string .
    DATA mv_bool_3state TYPE string .
    DATA mv_initial_ts TYPE string VALUE `""` ##NO_TEXT.
    DATA mv_initial_date TYPE string VALUE `""` ##NO_TEXT.
    DATA mv_initial_time TYPE string VALUE `""` ##NO_TEXT.
    DATA mv_time_zone LIKE sy-zonlo VALUE `UTC` ##NO_TEXT.
    DATA mv_compress TYPE bool .
    DATA mv_pretty_name TYPE pretty_name_mode .
    DATA mv_assoc_arrays TYPE bool .
    DATA mv_ts_as_iso8601 TYPE bool .
    DATA mv_expand_includes TYPE bool .
    DATA mv_assoc_arrays_opt TYPE bool .
    DATA mv_strict_mode TYPE bool .
    DATA mv_numc_as_string TYPE bool .
    DATA mv_format_output TYPE bool .
    DATA mv_conversion_exits TYPE bool .
    DATA mv_hex_as_base64 TYPE bool .
    DATA mv_gen_optimize TYPE bool .
    DATA mt_name_mappings TYPE name_mappings .
    DATA mt_name_mappings_ex TYPE name_mappings_ex .
    DATA mt_struct_type TYPE t_t_struct_type .
    DATA mt_struct_cache TYPE t_t_struct_cache .
    DATA:
      mt_ref_dump_idx TYPE SORTED TABLE OF REF TO data WITH UNIQUE DEFAULT KEY .
    DATA:
      mt_obj_dump_idx TYPE SORTED TABLE OF REF TO object WITH UNIQUE DEFAULT KEY .
    CLASS-DATA mc_name_symbols_map TYPE string VALUE ` _/_\_:_;_~_._,_-_+_=_>_<_|_(_)_[_]_{_}_@_+_*_?_!_&_$_#_%_^_'_` ##NO_TEXT.
    CONSTANTS mc_default_indent TYPE string VALUE `  ` ##NO_TEXT.
    CONSTANTS mc_typekind_utclong TYPE abap_typekind VALUE 'p' ##NO_TEXT. " CL_ABAP_TYPEDESCR=>TYPEKIND_UTCLONG -> 'p' only from 7.54
    CONSTANTS mc_typekind_int8 TYPE abap_typekind VALUE '8' ##NO_TEXT. " TYPEKIND_INT8 -> '8' only from 7.40
    CLASS-DATA so_type_s TYPE REF TO cl_abap_elemdescr .
    CLASS-DATA so_type_f TYPE REF TO cl_abap_elemdescr .
    CLASS-DATA so_type_p TYPE REF TO cl_abap_elemdescr .
    CLASS-DATA so_type_i TYPE REF TO cl_abap_elemdescr .
    CLASS-DATA so_type_b TYPE REF TO cl_abap_elemdescr .
    CLASS-DATA so_type_d TYPE REF TO cl_abap_elemdescr .
    CLASS-DATA so_type_t TYPE REF TO cl_abap_elemdescr .
    CLASS-DATA so_type_ts TYPE REF TO cl_abap_elemdescr .
    CLASS-DATA so_type_tsl TYPE REF TO cl_abap_elemdescr .
    CLASS-DATA so_type_t_json TYPE REF TO cl_abap_tabledescr .
    CLASS-DATA so_type_t_name_value TYPE REF TO cl_abap_tabledescr .
    CLASS-DATA so_regex_date TYPE REF TO cl_abap_regex.
    CLASS-DATA so_regex_time TYPE REF TO cl_abap_regex.
    CLASS-DATA so_regex_guid TYPE REF TO cl_abap_regex.
    CLASS-DATA so_regex_edm_date_time TYPE REF TO cl_abap_regex.
    CLASS-DATA so_regex_edm_time TYPE REF TO cl_abap_regex.
    CLASS-DATA so_regex_generate_normalize TYPE REF TO cl_abap_regex.
    CLASS-DATA so_regex_generate_camel_case TYPE REF TO cl_abap_regex.
    CLASS-DATA so_regex_generate_type_detect TYPE REF TO cl_abap_regex.
    CLASS-DATA so_regex_unescape_spec_char TYPE REF TO cl_abap_regex.

    CONSTANTS:
      BEGIN OF e_typekind,
        " new extended pseudo typekind, hack and can clash with standard if new enums come...
        " always check for duplicates !!!
        convexit    TYPE abap_typekind VALUE '1' ##NO_TEXT,
        ts_iso8601  TYPE abap_typekind VALUE '2' ##NO_TEXT,
        tsl_iso8601 TYPE abap_typekind VALUE '3' ##NO_TEXT,
        numc_string TYPE abap_typekind VALUE '4' ##NO_TEXT,
        json        TYPE abap_typekind VALUE '5' ##NO_TEXT,
        bool        TYPE abap_typekind VALUE '6' ##NO_TEXT,
        tribool     TYPE abap_typekind VALUE '7' ##NO_TEXT,

        " redefine for existing typekeinds for lower releases
        utclong     TYPE abap_typekind VALUE 'p' ##NO_TEXT, " CL_ABAP_TYPEDESCR=>TYPEKIND_UTCLONG -> 'p' only from 7.54
        int8        TYPE abap_typekind VALUE '8' ##NO_TEXT, " CL_ABAP_TYPEDESCR=>TYPEKIND_INT8 -> '8' only from 7.40
        enum        TYPE abap_typekind VALUE 'k' ##NO_TEXT, " CL_ABAP_TYPEDESCR=>TYPEKIND_ENUM -> 'k'

        " just aliasing
        float       TYPE abap_typekind VALUE cl_abap_typedescr=>typekind_float,
        int         TYPE abap_typekind VALUE cl_abap_typedescr=>typekind_int,
        int1        TYPE abap_typekind VALUE cl_abap_typedescr=>typekind_int1,
        int2        TYPE abap_typekind VALUE cl_abap_typedescr=>typekind_int2,
        packed      TYPE abap_typekind VALUE cl_abap_typedescr=>typekind_packed,
        num         TYPE abap_typekind VALUE cl_abap_typedescr=>typekind_num,
        string      TYPE abap_typekind VALUE cl_abap_typedescr=>typekind_string,
        csequence   TYPE abap_typekind VALUE cl_abap_typedescr=>typekind_csequence,
        clike       TYPE abap_typekind VALUE cl_abap_typedescr=>typekind_clike,
        char        TYPE abap_typekind VALUE cl_abap_typedescr=>typekind_char,
        date        TYPE abap_typekind VALUE cl_abap_typedescr=>typekind_date,
        time        TYPE abap_typekind VALUE cl_abap_typedescr=>typekind_time,
        xstring     TYPE abap_typekind VALUE cl_abap_typedescr=>typekind_xstring,
        hex         TYPE abap_typekind VALUE cl_abap_typedescr=>typekind_hex,

      END OF e_typekind .

    CLASS-METHODS unescape
      IMPORTING
        !offset          TYPE i DEFAULT 0
        !escaped         TYPE string
      RETURNING
        VALUE(unescaped) TYPE string .
    CLASS-METHODS get_convexit_func
      IMPORTING
        !elem_descr    TYPE REF TO cl_abap_elemdescr
        !input         TYPE abap_bool OPTIONAL
      RETURNING
        VALUE(rv_func) TYPE string .
    METHODS dump_symbols
      FINAL
      IMPORTING
        !it_symbols   TYPE t_t_symbol
        !opt_array    TYPE bool OPTIONAL
        !format_scope TYPE bool DEFAULT abap_true
        !level        TYPE i
      RETURNING
        VALUE(r_json) TYPE json .
    METHODS get_symbols_struct
      FINAL
      IMPORTING
        !type_descr      TYPE REF TO cl_abap_structdescr
        !include_aliases TYPE abap_bool DEFAULT abap_false
        !data            TYPE REF TO data OPTIONAL
        !level           TYPE i DEFAULT 0
      RETURNING
        VALUE(result)    TYPE t_s_struct_cache_res .
    METHODS get_symbols_class
      FINAL
      IMPORTING
        !type_descr   TYPE REF TO cl_abap_classdescr
        !object       TYPE REF TO object OPTIONAL
      RETURNING
        VALUE(result) TYPE t_t_symbol .
    METHODS get_symbols
      FINAL
      IMPORTING
        !type_descr      TYPE REF TO cl_abap_typedescr
        !data            TYPE REF TO data OPTIONAL
        !object          TYPE REF TO object OPTIONAL
        !include_aliases TYPE abap_bool DEFAULT abap_false
      RETURNING
        VALUE(result)    TYPE t_t_symbol .
    METHODS get_fields
      FINAL
      IMPORTING
        !type_descr      TYPE REF TO cl_abap_typedescr
        !data            TYPE REF TO data OPTIONAL
        !object          TYPE REF TO object OPTIONAL
      RETURNING
        VALUE(rt_fields) TYPE t_t_field_cache .
    METHODS dump_int
      IMPORTING
        !data         TYPE data
        !type_descr   TYPE REF TO cl_abap_typedescr OPTIONAL
        !convexit     TYPE string OPTIONAL
        !level        TYPE i DEFAULT 0
      RETURNING
        VALUE(r_json) TYPE json .
    METHODS is_compressable
      IMPORTING
        !type_descr        TYPE REF TO cl_abap_typedescr   ##NEEDED
        !name              TYPE csequence   ##NEEDED
      RETURNING
        VALUE(rv_compress) TYPE abap_bool .
    METHODS restore
      IMPORTING
        !json             TYPE json
        !length           TYPE i
        VALUE(type_descr) TYPE REF TO cl_abap_typedescr OPTIONAL
        !field_cache      TYPE t_t_field_cache OPTIONAL
      CHANGING
        !data             TYPE data OPTIONAL
        !offset           TYPE i DEFAULT 0
      RAISING
        cx_sy_move_cast_error .
    METHODS restore_type
      IMPORTING
        !json             TYPE json
        !length           TYPE i
        VALUE(type_descr) TYPE REF TO cl_abap_typedescr OPTIONAL
        !field_cache      TYPE t_t_field_cache OPTIONAL
        !convexit         TYPE string OPTIONAL
      CHANGING
        !data             TYPE data OPTIONAL
        !offset           TYPE i DEFAULT 0
      RAISING
        cx_sy_move_cast_error .
    METHODS dump_type
      IMPORTING
        !data         TYPE data
        !type_descr   TYPE REF TO cl_abap_elemdescr
        !convexit     TYPE string
        !typekind     TYPE abap_typekind OPTIONAL
      RETURNING
        VALUE(r_json) TYPE json .
    METHODS detect_typekind
      FINAL
      IMPORTING
        !type_descr    TYPE REF TO cl_abap_elemdescr
        !convexit      TYPE string
      RETURNING
        VALUE(rv_type) TYPE abap_typekind .
    METHODS dump_type_ex
      IMPORTING
        !data         TYPE data
      RETURNING
        VALUE(r_json) TYPE json .
    METHODS pretty_name_ex
      IMPORTING
        !in        TYPE csequence
      RETURNING
        VALUE(out) TYPE string .
    METHODS generate_int_ex
      FINAL
      IMPORTING
        !json   TYPE json
        !length TYPE i
      CHANGING
        !data   TYPE data
        !offset TYPE i .
    METHODS pretty_name
      IMPORTING
        !in        TYPE csequence
      RETURNING
        VALUE(out) TYPE string .
    CLASS-METHODS edm_datetime_to_ts
      IMPORTING
        !ticks        TYPE string
        !offset       TYPE string OPTIONAL
        !typekind     TYPE abap_typekind
      RETURNING
        VALUE(r_data) TYPE string .
    CLASS-METHODS get_indent
      IMPORTING
        !level        TYPE i DEFAULT 0
      RETURNING
        VALUE(indent) TYPE string .
    METHODS generate_struct
      CHANGING
        !fields TYPE t_t_name_value
        !data   TYPE REF TO data .
    CLASS-METHODS escape
      IMPORTING
        !in        TYPE any
      RETURNING
        VALUE(out) TYPE string .
  PRIVATE SECTION.

    DATA mv_extended TYPE bool .
    CLASS-DATA mc_cov_error TYPE c .
    CLASS-DATA mc_me_type TYPE string .
*"* private components of class Z_UI2_JSON
*"* do not include other source files here!!!
ENDCLASS.



CLASS Z_UI2_JSON IMPLEMENTATION.


  METHOD bool_to_tribool.
    IF iv_bool EQ c_bool-true.
      rv_tribool = c_tribool-true.
    ELSEIF iv_bool EQ abap_undefined. " fall back for abap _bool
      rv_tribool = c_tribool-undefined.
    ELSE.
      rv_tribool = c_tribool-false.
    ENDIF.
  ENDMETHOD.                    "bool_to_tribool


  METHOD class_constructor.

    DATA: lo_bool_type_descr    TYPE REF TO cl_abap_typedescr,
          lo_tribool_type_descr TYPE REF TO cl_abap_typedescr,
          lo_json_type_descr    TYPE REF TO cl_abap_typedescr,
          lv_pos                LIKE sy-fdpos,
          lv_nbsp               TYPE c LENGTH 1,
          lv_json_string        TYPE json.

    lo_bool_type_descr    = cl_abap_typedescr=>describe_by_data( c_bool-true ).
    lo_tribool_type_descr = cl_abap_typedescr=>describe_by_data( c_tribool-true ).
    lo_json_type_descr    = cl_abap_typedescr=>describe_by_data( lv_json_string ).

    CONCATENATE mc_bool_types lo_bool_type_descr->absolute_name lo_tribool_type_descr->absolute_name INTO mc_bool_types.
    CONCATENATE mc_bool_3state lo_tribool_type_descr->absolute_name INTO mc_bool_3state.
    CONCATENATE mc_json_type lo_json_type_descr->absolute_name INTO mc_json_type.

    FIND FIRST OCCURRENCE OF '\TYPE=' IN lo_json_type_descr->absolute_name MATCH OFFSET lv_pos.
    IF sy-subrc IS INITIAL.
      mc_me_type = lo_json_type_descr->absolute_name(lv_pos).
    ENDIF.

    sv_white_space = cl_abap_char_utilities=>get_simple_spaces_for_cur_cp( ).
    lv_nbsp = cl_abap_conv_in_ce=>uccp( '00A0' ).
    FIND FIRST OCCURRENCE OF lv_nbsp IN sv_white_space.
    IF sy-subrc IS NOT INITIAL. " add non-breakable space
      CONCATENATE sv_white_space lv_nbsp INTO sv_white_space.
    ENDIF.

    mc_cov_error = cl_abap_conv_in_ce=>uccp( '0000' ).

    so_type_s = cl_abap_elemdescr=>get_string( ).
    so_type_f = cl_abap_elemdescr=>get_f( ).
    so_type_p = cl_abap_elemdescr=>get_p( p_length = 16 p_decimals = 0 ).
    so_type_i = cl_abap_elemdescr=>get_i( ).
    so_type_d = cl_abap_elemdescr=>get_d( ).
    so_type_t = cl_abap_elemdescr=>get_t( ).
    so_type_ts ?= cl_abap_typedescr=>describe_by_name( 'TIMESTAMP' ).
    so_type_tsl ?= cl_abap_typedescr=>describe_by_name( 'TIMESTAMPL' ).
    so_type_b ?= cl_abap_typedescr=>describe_by_name( 'ABAP_BOOL' ).
    so_type_t_json ?= cl_abap_typedescr=>describe_by_name( 'T_T_JSON' ).
    so_type_t_name_value ?= cl_abap_typedescr=>describe_by_name( 'T_T_NAME_JSON' ).

    create_regexp so_regex_date '^(\d{4})-(\d{2})-(\d{2})(?:[^T]|$)'.
    create_regexp so_regex_time '^(\d{2}):(\d{2}):(\d{2})'.
    create_regexp so_regex_guid '^([0-9A-Fa-f]{8})-([0-9A-Fa-f]{4})-([0-9A-Fa-f]{4})-([0-9A-Fa-f]{4})-([0-9A-Fa-f]{12})\s*$'. " support for Edm.Guid
    " support for Edm.DateTime => http://www.odata.org/documentation/odata-version-2-0/json-format/
    create_regexp so_regex_edm_date_time '^\/[Dd][Aa][Tt][Ee]\((-?\d+)([+-]\d{1,4})?\)\/\s*$'.
    " support for Edm.Time => https://www.w3.org/TR/xmlschema11-2/#nt-durationRep
    create_regexp so_regex_edm_time '^-?P(?:(\d+)Y)?(?:(\d+)M)?(?:(\d+)D)?(?:T(?:(\d+)H)?(?:(\d+)M)?(?:(\d+)(?:\.(\d+))?S)?)?\s*$'.

    create_regexp so_regex_generate_normalize '[^0-9a-zA-Z_]{1,}'.
    create_regexp so_regex_generate_camel_case '([a-z])([A-Z])'.
    create_regexp so_regex_generate_type_detect '"(?:(?:\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}(?:[\.,]\d{0,9})?(?:Z|(?:[+-]\d{2}:\d{2})))|(?:\d{4}-\d{2}-\d{2})|(?:\d{2}:\d{2}:\d{2}))"'.

    create_regexp so_regex_unescape_spec_char '\\[rntfbu\\]'.

  ENDMETHOD.                    "class_constructor


  METHOD constructor.

    DATA: rtti TYPE REF TO cl_abap_classdescr,
          pair LIKE LINE OF name_mappings.

    mv_compress         = compress.
    mv_pretty_name      = pretty_name.
    mv_assoc_arrays     = assoc_arrays.
    mv_ts_as_iso8601    = ts_as_iso8601.
    mv_expand_includes  = expand_includes.
    mv_assoc_arrays_opt = assoc_arrays_opt.
    mv_strict_mode      = strict_mode.
    mv_numc_as_string   = numc_as_string.
    mv_conversion_exits = conversion_exits.
    mv_format_output    = format_output.
    mv_hex_as_base64    = hex_as_base64.
    mv_gen_optimize     = gen_optimize.
    mv_bool_types       = bool_types.
    mv_bool_3state      = bool_3state.
    mv_initial_ts       = initial_ts.
    mv_initial_date     = initial_date.
    mv_initial_time     = initial_time.
    mv_time_zone        = time_zone.

    LOOP AT name_mappings INTO pair.
      TRANSLATE pair-abap TO UPPER CASE.
      INSERT pair INTO TABLE mt_name_mappings.
    ENDLOOP.

    IF mt_name_mappings IS NOT INITIAL.

      " if it dumps here, you have passed ambiguous mapping to the API
      " Please check your code for duplicates, pairs ABAP - JSON shall be unique
      " and there shall be no ambiguity for looking up only by JSON name (deserialize, generate)
      " and no ambiguity for looking up only by ABAP name (serialize)
      " per default, serializer/deserializer tries to have lossless conversion from JSON to ABAP and vice versa
      INSERT LINES OF mt_name_mappings INTO TABLE mt_name_mappings_ex.

      IF mv_pretty_name EQ pretty_mode-none.
        mv_pretty_name = pretty_mode-user.
      ELSEIF pretty_name EQ pretty_mode-low_case.
        mv_pretty_name = pretty_mode-user_low_case.
      ENDIF.

    ENDIF.

    rtti ?= cl_abap_classdescr=>describe_by_object_ref( me ).
    IF rtti->absolute_name NE mc_me_type.
      mv_extended = c_bool-true.
    ENDIF.

  ENDMETHOD.


  METHOD deserialize.

    CONSTANTS: lc_method TYPE string VALUE `DESERIALIZE_INT`.

    DATA: lo_json TYPE REF TO object.

    " **********************************************************************
    " Usage examples and documentation can be found on GitHub:
    " https://github.com/SAP/abap-to-json
    " **********************************************************************  "

    IF json IS NOT INITIAL OR jsonx IS NOT INITIAL.

      CREATE OBJECT lo_json TYPE (mc_me_type)
        EXPORTING
          pretty_name      = pretty_name
          name_mappings    = name_mappings
          assoc_arrays     = assoc_arrays
          conversion_exits = conversion_exits
          hex_as_base64    = hex_as_base64
          gen_optimize     = gen_optimize
          assoc_arrays_opt = assoc_arrays_opt.

      TRY .
          CALL METHOD lo_json->(lc_method)
            EXPORTING
              json  = json
              jsonx = jsonx
            CHANGING
              data  = data.
        CATCH cx_sy_move_cast_error.                    "#EC NO_HANDLER
      ENDTRY.

    ENDIF.

  ENDMETHOD.                    "deserialize


  METHOD deserialize_int.

    DATA: length  TYPE i,
          offset  TYPE i,
          lx_move TYPE REF TO cx_sy_move_cast_error,
          lv_json LIKE json.

    " **********************************************************************
    " Usage examples and documentation can be found on GitHub:
    " https://github.com/SAP/abap-to-json
    " **********************************************************************  "

    CHECK  json IS NOT INITIAL OR jsonx IS NOT INITIAL.

    IF jsonx IS NOT INITIAL.
      lv_json =  cl_abap_codepage=>convert_from( jsonx ).
    ELSE.
      lv_json = json.
    ENDIF.

    " skip leading BOM signs till string, array, object, boolean or number
    length = strlen( lv_json ).
    while_offset_not_cs '"{[aeflnrstu0123456789+-eE.' lv_json offset.

    TRY.
        restore_type( EXPORTING json = lv_json length = length CHANGING data = data offset = offset ).
      CATCH cx_sy_move_cast_error INTO lx_move.
        RAISE EXCEPTION TYPE cx_sy_move_cast_error
          EXPORTING
            previous        = lx_move
            source_typename = `$.` && lx_move->source_typename
            target_typename = lx_move->target_typename.
    ENDTRY.

  ENDMETHOD.                    "deserialize


  METHOD dump.

    CONSTANTS: lc_method TYPE string VALUE `DUMP_INT`.

    DATA: lo_json TYPE REF TO object.

    CREATE OBJECT lo_json TYPE (mc_me_type)
      EXPORTING
        compress      = compress
        pretty_name   = pretty_name
        assoc_arrays  = assoc_arrays
        ts_as_iso8601 = ts_as_iso8601.

    CALL METHOD lo_json->(lc_method)
      EXPORTING
        data       = data
        type_descr = type_descr
      RECEIVING
        r_json     = r_json.

  ENDMETHOD.                    "dump


  METHOD dump_int.

    DATA: lo_typedesc   TYPE REF TO cl_abap_typedescr,
          lo_elem_descr TYPE REF TO cl_abap_elemdescr,
          lo_classdesc  TYPE REF TO cl_abap_classdescr,
          lo_structdesc TYPE REF TO cl_abap_structdescr,
          lo_tabledescr TYPE REF TO cl_abap_tabledescr,
          ls_struct_sym TYPE t_s_struct_cache_res,
          lt_symbols    TYPE t_t_symbol,
          lt_keys       TYPE STANDARD TABLE OF REF TO data WITH DEFAULT KEY,
          lt_properties TYPE STANDARD TABLE OF string,
          lo_obj_ref    TYPE REF TO object,
          lo_data_ref   TYPE REF TO data,
          ls_skip_key   TYPE LINE OF abap_keydescr_tab,
          lv_array_opt  TYPE abap_bool,
          indent        TYPE string,
          lv_indent     LIKE indent,
          lv_level      LIKE level,
          lv_lb         TYPE string,
          lv_prop_name  TYPE string,
          lv_keyval     TYPE string,
          lv_typekind   TYPE abap_typekind,
          lv_itemval    TYPE string,
          lv_property   TYPE string.

    FIELD-SYMBOLS: <line>   TYPE any,
                   <value>  TYPE any,
                   <data>   TYPE data,
                   <key>    TYPE LINE OF abap_keydescr_tab,
                   <symbol> TYPE t_s_symbol,
                   <table>  TYPE ANY TABLE.

    " increase hierarchy level
    lv_level = level + 1.

    " we need here macro instead of method calls because of the performance reasons.
    " based on SAT measurements.

    CASE type_descr->kind.
      WHEN cl_abap_typedescr=>kind_ref.

        IF data IS INITIAL.
          r_json = `null`.                                  "#EC NOTEXT
        ELSEIF type_descr->type_kind EQ cl_abap_typedescr=>typekind_dref.
          lo_data_ref ?= data.
          INSERT lo_data_ref INTO TABLE mt_ref_dump_idx.
          IF sy-subrc IS INITIAL. "not dumped yet
            lo_typedesc = cl_abap_typedescr=>describe_by_data_ref( lo_data_ref ).
            ASSIGN lo_data_ref->* TO <data>.
            r_json = dump_int( data = <data> type_descr = lo_typedesc level = level ).
            DELETE TABLE mt_ref_dump_idx WITH TABLE KEY table_line = lo_data_ref.
          ELSE.
            " it is a cycle reference, we can not proceed, so terminate and write empty object instead
            r_json = `{}`.                                  "#EC NOTEXT
          ENDIF.
        ELSE.
          lo_obj_ref ?= data.
          INSERT lo_obj_ref INTO TABLE mt_obj_dump_idx.
          IF sy-subrc IS INITIAL. "not dumped yet
            lo_classdesc ?= cl_abap_typedescr=>describe_by_object_ref( lo_obj_ref ).
            lt_symbols = get_symbols_class( type_descr = lo_classdesc object = lo_obj_ref ).
            r_json = dump_symbols( it_symbols = lt_symbols level = level ).
            DELETE TABLE mt_obj_dump_idx WITH TABLE KEY table_line = lo_obj_ref.
          ELSE.
            " it is a cycle reference, we can not proceed, so terminate and write empty object instead
            r_json = `{}`.                                  "#EC NOTEXT
          ENDIF.
        ENDIF.

      WHEN cl_abap_typedescr=>kind_elem.
        lo_elem_descr ?= type_descr.
        lv_typekind = detect_typekind( type_descr = lo_elem_descr convexit = convexit ).
        dump_type data lo_elem_descr lv_typekind r_json convexit.

      WHEN cl_abap_typedescr=>kind_struct.

        lo_structdesc ?= type_descr.

        ls_struct_sym = get_symbols_struct( type_descr = lo_structdesc level = level ).
        ASSIGN ls_struct_sym-data->* TO <data>.
        <data> = data.

        r_json = dump_symbols( it_symbols = ls_struct_sym-symbols level = level ).

      WHEN cl_abap_typedescr=>kind_table.

        lo_tabledescr ?= type_descr.
        lo_typedesc = lo_tabledescr->get_table_line_type( ).

        ASSIGN data TO <table>.

        IF mv_format_output EQ abap_true.
          indent = get_indent( level ).
          lv_indent = get_indent( lv_level ).
        ENDIF.

        " optimization for structured tables
        IF lo_typedesc->kind EQ cl_abap_typedescr=>kind_struct.
          lo_structdesc ?= lo_typedesc.

          ls_struct_sym = get_symbols_struct( type_descr = lo_structdesc level = level ).
          ASSIGN ls_struct_sym-data->* TO <line>.

          " here we have differentiation of output of simple table to JSON array
          " and sorted or hashed table with unique key into JSON associative array
          IF lo_tabledescr->has_unique_key IS NOT INITIAL AND mv_assoc_arrays IS NOT INITIAL.

            IF lo_tabledescr->key_defkind EQ lo_tabledescr->keydefkind_user.
              LOOP AT lo_tabledescr->key ASSIGNING <key>.
                READ TABLE ls_struct_sym-symbols WITH KEY name = <key>-name ASSIGNING <symbol>.
                APPEND <symbol>-value TO lt_keys.
              ENDLOOP.
            ENDIF.

            IF lines( lo_tabledescr->key ) EQ 1.
              READ TABLE lo_tabledescr->key INDEX 1 INTO ls_skip_key.
              DELETE ls_struct_sym-symbols WHERE name EQ ls_skip_key-name.
              " remove object wrapping for simple name-value tables
              IF mv_assoc_arrays_opt EQ abap_true AND lines( ls_struct_sym-symbols ) EQ 1.
                lv_array_opt = abap_true.
              ENDIF.
            ENDIF.

            LOOP AT <table> INTO <line>.
              CLEAR: lv_prop_name.
              " construct key attribute name
              IF lo_tabledescr->key_defkind EQ lo_tabledescr->keydefkind_user.
                LOOP AT lt_keys INTO lo_data_ref.
                  ASSIGN lo_data_ref->* TO <value>.
                  lv_keyval = <value>.
                  CONDENSE lv_keyval.
                  IF lv_prop_name IS NOT INITIAL.
                    CONCATENATE lv_prop_name mc_key_separator lv_keyval INTO lv_prop_name.
                  ELSE.
                    lv_prop_name = lv_keyval.
                  ENDIF.
                ENDLOOP.
              ELSE.
                LOOP AT ls_struct_sym-symbols ASSIGNING <symbol>.
                  ASSIGN <symbol>-value->* TO <value>.
                  lv_keyval = <value>.
                  CONDENSE lv_keyval.
                  IF lv_prop_name IS NOT INITIAL.
                    CONCATENATE lv_prop_name mc_key_separator lv_keyval INTO lv_prop_name.
                  ELSE.
                    lv_prop_name = lv_keyval.
                  ENDIF.
                ENDLOOP.
              ENDIF.

              lv_itemval = dump_symbols( it_symbols = ls_struct_sym-symbols opt_array = lv_array_opt format_scope = abap_false level = lv_level ).
              IF lv_array_opt EQ abap_true.
                IF mv_format_output EQ abap_true AND lv_itemval IS NOT INITIAL.
                  CONCATENATE '"' lv_prop_name '": ' lv_itemval INTO lv_property RESPECTING BLANKS.
                ELSE.
                  CONCATENATE '"' lv_prop_name '":' lv_itemval INTO lv_property.
                ENDIF.
              ELSE.
                IF mv_format_output EQ abap_true AND lv_itemval IS NOT INITIAL.
                  CONCATENATE '"' lv_prop_name '": {' lv_itemval lv_indent '}' INTO lv_property.
                ELSE.
                  CONCATENATE '"' lv_prop_name '":{' lv_itemval '}' INTO lv_property.
                ENDIF.
              ENDIF.
              APPEND lv_property TO lt_properties.

            ENDLOOP.

            format_list_output '{' lt_properties '}' r_json.

          ELSE.
            LOOP AT <table> INTO <line>.
              lv_itemval = dump_symbols( it_symbols = ls_struct_sym-symbols level = lv_level ).
              APPEND lv_itemval TO lt_properties.
            ENDLOOP.

            format_list_output '[' lt_properties ']' r_json.

          ENDIF.
        ELSE.
          LOOP AT <table> ASSIGNING <value>.
            lv_itemval = dump_int( data = <value> type_descr = lo_typedesc level = lv_level ).
            APPEND lv_itemval TO lt_properties.
          ENDLOOP.

          format_list_output '[' lt_properties ']' r_json.

        ENDIF.

    ENDCASE.

  ENDMETHOD.                    "dump


  METHOD dump_symbols.

    DATA: lt_fields  TYPE STANDARD TABLE OF string INITIAL SIZE 10000,
          lv_indent  TYPE string,
          lv_level   LIKE level,
          lv_itemval TYPE string,
          lv_field   TYPE string.

    FIELD-SYMBOLS: <value>  TYPE any,
                   <symbol> LIKE LINE OF it_symbols.

    " increase hierarchy level
    lv_level = level + 1.

    IF mv_format_output EQ abap_true AND opt_array EQ abap_false.
      lv_indent = get_indent( lv_level ).
    ENDIF.

    LOOP AT it_symbols ASSIGNING <symbol>.
      ASSIGN <symbol>-value->* TO <value>.
      CHECK <symbol>-compressable EQ abap_false OR <value> IS NOT INITIAL OR opt_array EQ abap_true.
      IF <symbol>-elem_type IS NOT INITIAL.
        dump_type <value> <symbol>-elem_type <symbol>-typekind lv_itemval <symbol>-convexit_out.
      ELSE.
        lv_itemval = dump_int( data = <value> type_descr = <symbol>-type convexit = <symbol>-convexit_out level = lv_level ).
      ENDIF.
      IF opt_array EQ abap_false.
        IF mv_format_output EQ abap_true.
          CONCATENATE lv_indent <symbol>-header lv_itemval INTO lv_field.
        ELSE.
          CONCATENATE <symbol>-header lv_itemval INTO lv_field.
        ENDIF.
      ELSE.
        lv_field = lv_itemval.
      ENDIF.
      APPEND lv_field TO lt_fields.
    ENDLOOP.

    CONCATENATE LINES OF lt_fields INTO r_json SEPARATED BY ','.

    IF format_scope EQ abap_true.
      IF r_json IS INITIAL.
        r_json = `{}`.
      ELSEIF mv_format_output EQ abap_true.
        lv_indent = get_indent( level ).
        CONCATENATE '{' r_json lv_indent '}' INTO r_json.
      ELSE.
        CONCATENATE '{' r_json '}' INTO r_json.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD dump_type.

    DATA: lv_typekind LIKE typekind.

    ""!!! the fallback code for missing typekind is only for the method but not used in macro
    IF typekind IS INITIAL.
      lv_typekind = detect_typekind( type_descr = type_descr convexit = convexit ).
    ELSE.
      lv_typekind = typekind.
    ENDIF.
    ""!!!!

    CASE lv_typekind.
      WHEN e_typekind-convexit.
        IF data IS INITIAL.
          r_json = `""`.
        ELSE.
          TRY.
              DATA: char128 TYPE c LENGTH 128.
              CALL FUNCTION convexit
                EXPORTING
                  input  = data
                IMPORTING
                  output = char128
                EXCEPTIONS
                  OTHERS = 1.
              IF sy-subrc IS INITIAL.
                CONCATENATE '"' char128 '"' INTO r_json.
              ENDIF.
            CATCH cx_root ##CATCH_ALL ##NO_HANDLER.
          ENDTRY.
        ENDIF.
      WHEN e_typekind-utclong.
        IF data IS INITIAL.
          r_json = mv_initial_ts.
        ELSE.
          DATA: utcl TYPE c LENGTH 27.
          utcl = data.
          CONCATENATE '"' utcl(10) 'T' utcl+11(16) 'Z"'  INTO r_json.
        ENDIF.
      WHEN e_typekind-ts_iso8601.
        IF data IS INITIAL.
          r_json = mv_initial_ts.
        ELSE.
          DATA: ts TYPE c LENGTH 14.
          ts = data.
          CONCATENATE '"' ts(4) '-' ts+4(2) '-' ts+6(2) 'T' ts+8(2) ':' ts+10(2) ':' ts+12(2) 'Z"'  INTO r_json.
        ENDIF.
      WHEN e_typekind-tsl_iso8601.
        IF data IS INITIAL.
          r_json = mv_initial_ts.
        ELSE.
          DATA: tsl TYPE c LENGTH 22.
          tsl = data.
          CONCATENATE '"' tsl(4) '-' tsl+4(2) '-' tsl+6(2) 'T' tsl+8(2) ':' tsl+10(2) ':' tsl+12(2) '.' tsl+15(7) 'Z"'  INTO r_json.
        ENDIF.
      WHEN e_typekind-float.
        IF data IS INITIAL.
          r_json = `0`.
        ELSE.
          r_json = data.
        ENDIF.
      WHEN e_typekind-int OR e_typekind-int1 OR e_typekind-int2 OR e_typekind-packed OR e_typekind-int8.
        IF data IS INITIAL.
          r_json = `0`.
        ELSE.
          r_json = data.
          IF data LT 0.
            SHIFT r_json RIGHT CIRCULAR.
          ELSE.
            CONDENSE r_json.
          ENDIF.
        ENDIF.
      WHEN e_typekind-numc_string.
        IF data IS INITIAL.
          r_json = `""`.
        ELSE.
          CONCATENATE '"' data '"' INTO r_json.
        ENDIF.
      WHEN e_typekind-num.
        IF data IS INITIAL.
          r_json = `0`.
        ELSE.
          r_json = data.
          SHIFT r_json LEFT DELETING LEADING '0'.
        ENDIF.
      WHEN e_typekind-json.
        r_json = data.
      WHEN e_typekind-string OR e_typekind-csequence OR e_typekind-clike OR e_typekind-char.
        IF data IS INITIAL.
          r_json = `""`.
        ELSE.
          escape_json data r_json.
          CONCATENATE '"' r_json '"' INTO r_json.
        ENDIF.
      WHEN cl_abap_typedescr=>typekind_xstring OR cl_abap_typedescr=>typekind_hex.
        IF data IS INITIAL.
          r_json = `""`.
        ELSE.
          xstring_to_string_int data r_json.
          CONCATENATE '"' r_json '"' INTO r_json.
        ENDIF.
      WHEN e_typekind-bool OR e_typekind-tribool.
        IF data EQ c_bool-true.
          r_json = `true`.                                  "#EC NOTEXT
        ELSEIF data IS INITIAL AND lv_typekind EQ e_typekind-tribool.
          r_json = `null`.                                  "#EC NOTEXT
        ELSE.
          r_json = `false`.                                 "#EC NOTEXT
        ENDIF.
      WHEN e_typekind-date.
        IF data IS INITIAL.
          r_json = mv_initial_date.
        ELSE.
          CONCATENATE '"' data(4) '-' data+4(2) '-' data+6(2) '"' INTO r_json.
        ENDIF.
      WHEN e_typekind-time.
        IF data IS INITIAL.
          r_json = mv_initial_time.
        ELSE.
          CONCATENATE '"' data(2) ':' data+2(2) ':' data+4(2) '"' INTO r_json.
        ENDIF.
      WHEN e_typekind-enum.
        r_json = data.
        CONCATENATE '"' r_json '"' INTO r_json.
      WHEN OTHERS.
        IF data IS INITIAL.
          r_json = `null`.                                  "#EC NOTEXT
        ELSE.
          r_json = data.
        ENDIF.
    ENDCASE.

  ENDMETHOD.                    "dump_type


  METHOD dump_type_ex.

    DATA: lo_descr    TYPE REF TO cl_abap_elemdescr,
          lv_convexit TYPE string.

    lo_descr ?= cl_abap_typedescr=>describe_by_data( data ).

    IF mv_conversion_exits EQ abap_true.
      lv_convexit = get_convexit_func( elem_descr = lo_descr input = abap_false ).
    ENDIF.

    r_json = dump_type( data = data type_descr = lo_descr convexit = lv_convexit ).

  ENDMETHOD.                    "DUMP_TYPE_EX


  METHOD edm_datetime_to_ts.

    CONSTANTS: lc_epochs TYPE string VALUE `19700101000000`.

    DATA: lv_ticks      TYPE p,
          lv_seconds    TYPE p,
          lv_subsec     TYPE p,
          lv_timestamps TYPE string,
          lv_timestamp  TYPE timestampl VALUE `19700101000000.0000000`.

    lv_ticks     = ticks.
    lv_seconds   = lv_ticks / 1000. " in seconds
    lv_subsec    = lv_ticks MOD 1000. " in subsec
    IF lv_subsec GT 0.
      lv_timestamps = lv_subsec.
      CONCATENATE lc_epochs '.' lv_timestamps INTO lv_timestamps.
      lv_timestamp = lv_timestamps.
    ENDIF.
    lv_timestamp = cl_abap_tstmp=>add( tstmp = lv_timestamp secs = lv_seconds ).

    IF offset IS NOT INITIAL.
      lv_ticks = offset+1.
      lv_ticks = lv_ticks * 60. "offset is in minutes
      IF offset(1) = '+'.
        lv_timestamp = cl_abap_tstmp=>subtractsecs( tstmp = lv_timestamp secs = lv_ticks ).
      ELSE.
        lv_timestamp = cl_abap_tstmp=>add( tstmp = lv_timestamp secs = lv_ticks ).
      ENDIF.
    ENDIF.

    CASE typekind.
      WHEN cl_abap_typedescr=>typekind_time.
        r_data = lv_timestamp.
        r_data = r_data+8(6).
      WHEN cl_abap_typedescr=>typekind_date.
        r_data = lv_timestamp.
        r_data = r_data(8).
      WHEN cl_abap_typedescr=>typekind_packed.
        r_data = lv_timestamp.
    ENDCASE.

  ENDMETHOD.


  METHOD escape.
    escape_json in out.
  ENDMETHOD.


  METHOD generate.

    deserialize( EXPORTING json = json jsonx = jsonx  gen_optimize = optimize pretty_name = pretty_name name_mappings = name_mappings CHANGING data = rr_data ).

  ENDMETHOD.


  METHOD generate_int.

    DATA: lt_json        TYPE t_t_json,
          mark           LIKE offset,
          match          LIKE offset,
          data_opt       LIKE data,
          lo_type        TYPE REF TO cl_abap_datadescr,
          lo_table_type  TYPE REF TO cl_abap_tabledescr,
          lt_types       TYPE SORTED TABLE OF REF TO cl_abap_datadescr WITH UNIQUE KEY table_line,
          lt_fields      TYPE t_t_name_value,
          lt_json_fields TYPE t_t_name_json.

    FIELD-SYMBOLS: <data>      TYPE data,
                   <struct>    TYPE data,
                   <value>     TYPE data,
                   <json>      LIKE LINE OF lt_json,
                   <field>     LIKE LINE OF lt_fields,
                   <table>     TYPE STANDARD TABLE,
                   <table_opt> LIKE <table>.

    IF length IS NOT SUPPLIED.
      length = strlen( json ).
    ENDIF.

    eat_white.

    CASE json+offset(1).
      WHEN '{'."result must be a structure
        restore_type( EXPORTING json = json length = length type_descr = so_type_t_name_value CHANGING offset = offset data = lt_json_fields ).
        MOVE-CORRESPONDING lt_json_fields TO lt_fields.
        IF mv_gen_optimize EQ abap_true.
          LOOP AT lt_fields ASSIGNING <field>.
            generate_int( EXPORTING json = <field>-value CHANGING data = <field>-data ).
          ENDLOOP.
          generate_struct( CHANGING fields = lt_fields data = data ).
          IF data IS BOUND.
            ASSIGN data->* TO <struct>.
            LOOP AT lt_fields ASSIGNING <field>.
              ASSIGN COMPONENT sy-tabix OF STRUCTURE <struct> TO <data>.
              CHECK <field>-data IS NOT INITIAL.
              ASSIGN <field>-data->* TO <value>.
              <data> = <value>.
            ENDLOOP.
          ENDIF.
        ELSE.
          generate_struct( CHANGING fields = lt_fields data = data ).
          IF data IS BOUND.
            ASSIGN data->* TO <struct>.
            LOOP AT lt_fields ASSIGNING <field>.
              ASSIGN COMPONENT sy-tabix OF STRUCTURE <struct> TO <data>.
              generate_int( EXPORTING json = <field>-value CHANGING data = <data> ).
            ENDLOOP.
          ENDIF.
        ENDIF.
      WHEN '['."result must be a table of ref
        restore_type( EXPORTING json = json length = length type_descr = so_type_t_json CHANGING offset = offset data = lt_json ).
        CREATE DATA data TYPE ref_tab.
        ASSIGN data->* TO <table>.
        LOOP AT lt_json ASSIGNING <json>.
          APPEND INITIAL LINE TO <table> ASSIGNING <data>.
          generate_int( EXPORTING json = <json> CHANGING data = <data> ).
          IF mv_gen_optimize EQ abap_true AND <data> IS NOT INITIAL.
            lo_type ?= cl_abap_typedescr=>describe_by_data_ref( <data> ).
            INSERT lo_type INTO TABLE lt_types.
          ENDIF.
        ENDLOOP.
        IF mv_gen_optimize EQ abap_true AND lines( lt_types ) EQ 1.
          lo_table_type = cl_abap_tabledescr=>get( p_line_type = lo_type ).
          CREATE DATA data_opt TYPE HANDLE lo_table_type.
          ASSIGN data_opt->* TO <table_opt>.
          LOOP AT <table> ASSIGNING <data>.
            ASSIGN <data>->* TO <value>.
            APPEND <value> TO <table_opt>.
          ENDLOOP.
          data = data_opt.
        ENDIF.
      WHEN '"'."string
        FIND FIRST OCCURRENCE OF REGEX so_regex_generate_type_detect IN SECTION OFFSET offset
        OF json MATCH LENGTH match.
        IF sy-subrc IS INITIAL.
          CASE match.
            WHEN 10. " time
              restore_reference so_type_t.
            WHEN 12. " date
              restore_reference so_type_d.
            WHEN OTHERS. " timestamp(L)
              IF json+offset(match) CA '.'. " TIMESTAMPL
                restore_reference so_type_tsl.
              ELSE.
                restore_reference so_type_ts.
              ENDIF.
          ENDCASE.
        ELSE.
          restore_reference so_type_s.
        ENDIF.
      WHEN '-' OR '0' OR '1' OR '2' OR '3' OR '4' OR '5' OR '6' OR '7' OR '8' OR '9'. " number
        IF offset EQ 0.
          match = length.
        ELSE.
          mark = offset.
          while_offset_cs '0123456789+-eE.' mark.
          match = mark - offset.
        ENDIF.
        IF json+offset(match) CA '.Ee'.
          restore_reference so_type_f.
        ELSEIF match GT 9.
          restore_reference so_type_p.
        ELSE.
          restore_reference so_type_i.
        ENDIF.
      WHEN OTHERS.
        IF offset EQ 0.
          match = length.
        ELSE.
          mark   = offset.
          while_offset_cs 'aeflnrstu' mark.
          match = mark - offset.
        ENDIF.
        IF json+offset(match) EQ 'true' OR json+offset(match) EQ 'false'. "#EC NOTEXT
          restore_reference so_type_b.
        ELSE. "null or no match
          CLEAR data.
        ENDIF.
    ENDCASE.

  ENDMETHOD.


  METHOD generate_int_ex.

    DATA: lv_assoc_arrays     LIKE mv_assoc_arrays,
          lv_assoc_arrays_opt LIKE mv_assoc_arrays_opt.

    lv_assoc_arrays     = mv_assoc_arrays.
    lv_assoc_arrays_opt = mv_assoc_arrays_opt.

    mv_assoc_arrays     = abap_true.
    mv_assoc_arrays_opt = abap_true.

    generate_int( EXPORTING json = json length = length CHANGING offset = offset data = data ).

    mv_assoc_arrays = lv_assoc_arrays.
    mv_assoc_arrays_opt = lv_assoc_arrays_opt.

  ENDMETHOD.


  METHOD generate_struct.

    DATA: lv_comp_name TYPE abap_compname,
          lt_comp      TYPE abap_component_tab,
          lt_keys      TYPE STANDARD TABLE OF string,
          lv_invalid   TYPE abap_bool,
          ls_type      LIKE LINE OF mt_struct_type,
          lt_names     TYPE HASHED TABLE OF string WITH UNIQUE KEY table_line,
          lo_data_type TYPE REF TO cl_abap_datadescr,
          cache        LIKE LINE OF mt_name_mappings_ex,
          ls_comp      LIKE LINE OF lt_comp.

    FIELD-SYMBOLS: <field> LIKE LINE OF fields,
                   <cache> LIKE LINE OF mt_name_mappings_ex.

    CHECK fields IS NOT INITIAL.

    " prepare structure type key
    LOOP AT fields ASSIGNING <field>.
      APPEND <field>-name TO lt_keys.
      CHECK <field>-data IS NOT INITIAL.
      lo_data_type ?= cl_abap_typedescr=>describe_by_data_ref( <field>-data ).
      APPEND lo_data_type->absolute_name TO lt_keys.
    ENDLOOP.

    CONCATENATE LINES OF lt_keys INTO ls_type-keys.
    ls_type-keys = lcl_util=>to_md5( ls_type-keys ).

    READ TABLE mt_struct_type WITH TABLE KEY keys = ls_type-keys INTO ls_type.
    IF sy-subrc IS NOT INITIAL.

      LOOP AT fields ASSIGNING <field>.

        " create type name
        READ TABLE mt_name_mappings_ex WITH TABLE KEY json = <field>-name ASSIGNING <cache>.
        IF sy-subrc IS INITIAL.
          ls_comp-name = <cache>-abap.
        ELSE.
          cache-json = ls_comp-name = <field>-name.
          " remove characters not allowed in component names and condense
          REPLACE ALL OCCURRENCES OF REGEX so_regex_generate_normalize IN ls_comp-name WITH '_'.
          IF mv_pretty_name EQ pretty_mode-camel_case OR mv_pretty_name EQ pretty_mode-extended.
            REPLACE ALL OCCURRENCES OF REGEX so_regex_generate_camel_case IN ls_comp-name WITH '$1_$2'.
          ENDIF.
          TRANSLATE ls_comp-name TO UPPER CASE.
          cache-abap = ls_comp-name = lv_comp_name = ls_comp-name. " truncate by allowed field name length
          INSERT cache INTO TABLE mt_name_mappings_ex.
        ENDIF.

        " detect type
        IF <field>-data IS INITIAL.
          ls_comp-type = cl_abap_refdescr=>get_ref_to_data( ).
        ELSE.
          ls_comp-type ?= cl_abap_typedescr=>describe_by_data_ref( <field>-data ).
        ENDIF.

        INSERT ls_comp-name INTO TABLE lt_names.
        IF sy-subrc IS INITIAL.
          APPEND ls_comp TO lt_comp.
        ELSE.
          DELETE fields.
          lv_invalid = abap_true.
        ENDIF.
      ENDLOOP.

      TRY.
          ls_type-type = cl_abap_structdescr=>create( p_components = lt_comp p_strict = c_bool-false ).
        CATCH cx_sy_struct_creation.                    "#EC NO_HANDLER
      ENDTRY.

      IF lv_invalid EQ abap_false.
        INSERT ls_type INTO TABLE mt_struct_type.
      ENDIF.

    ENDIF.

    IF ls_type-type IS NOT INITIAL.
      TRY.
          CREATE DATA data TYPE HANDLE ls_type-type.
        CATCH cx_sy_create_data_error.                  "#EC NO_HANDLER
      ENDTRY.
    ENDIF.

  ENDMETHOD.


  METHOD get_convexit_func.

    DATA: ls_dfies     TYPE dfies.

    elem_descr->get_ddic_field(
      RECEIVING
        p_flddescr   = ls_dfies    " Field Description
      EXCEPTIONS
        not_found    = 1
        no_ddic_type = 2
        OTHERS       = 3
    ).
    IF sy-subrc IS INITIAL AND ls_dfies-convexit IS NOT INITIAL.
      IF input EQ abap_true.
        CONCATENATE 'CONVERSION_EXIT_' ls_dfies-convexit '_INPUT' INTO rv_func.
      ELSE.
        CONCATENATE 'CONVERSION_EXIT_' ls_dfies-convexit '_OUTPUT' INTO rv_func.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD get_fields.

    DATA: lt_symbols TYPE t_t_symbol,
          lv_name    TYPE char128,
          ls_field   LIKE LINE OF rt_fields.

    FIELD-SYMBOLS: <sym>   LIKE LINE OF lt_symbols,
                   <cache> LIKE LINE OF mt_name_mappings.

    lt_symbols = get_symbols( type_descr = type_descr data = data object = object include_aliases = abap_true ).

    LOOP AT lt_symbols ASSIGNING <sym> WHERE read_only EQ abap_false.
      MOVE-CORRESPONDING <sym> TO ls_field.

      " insert as UPPER CASE
      INSERT ls_field INTO TABLE rt_fields.

      " insert as lower case
      TRANSLATE ls_field-name TO LOWER CASE.
      INSERT ls_field INTO TABLE rt_fields.

      " as pretty printed
      IF mv_pretty_name NE pretty_mode-none AND mv_pretty_name NE pretty_mode-low_case.
        format_name <sym>-name mv_pretty_name ls_field-name.
        INSERT ls_field INTO TABLE rt_fields.
        " let us check for not well formed canelCase to be compatible with old logic
        lv_name = ls_field-name.
        TRANSLATE lv_name(1) TO UPPER CASE.
        ls_field-name = lv_name.
        INSERT ls_field INTO TABLE rt_fields.
      ENDIF.

    ENDLOOP.

  ENDMETHOD.


  METHOD get_indent.

    STATICS: st_indent TYPE STANDARD TABLE OF string WITH DEFAULT KEY.

    DATA: lv_filled TYPE i.

    READ TABLE st_indent INDEX level INTO indent.
    IF sy-subrc IS NOT INITIAL.
      lv_filled = lines( st_indent ).
      indent = cl_abap_char_utilities=>cr_lf.
      DO level TIMES.
        CONCATENATE indent mc_default_indent INTO indent.
        IF sy-index GT lv_filled.
          APPEND indent TO st_indent.
        ENDIF.
      ENDDO.
    ENDIF.

  ENDMETHOD.


  METHOD get_symbols.

    DATA: class_descr  TYPE REF TO cl_abap_classdescr,
          struct_descr TYPE REF TO cl_abap_structdescr,
          struct_cache TYPE t_s_struct_cache_res.

    IF type_descr->kind EQ cl_abap_typedescr=>kind_struct.

      struct_descr ?= type_descr.
      struct_cache = get_symbols_struct( type_descr = struct_descr data = data include_aliases = include_aliases ).
      result = struct_cache-symbols.

    ELSEIF type_descr->type_kind EQ cl_abap_typedescr=>typekind_class.

      class_descr ?= type_descr.
      result = get_symbols_class( type_descr = class_descr object = object ).

    ENDIF.

  ENDMETHOD.                    "GET_SYMBOLS


  METHOD get_symbols_class.

    DATA: symb       LIKE LINE OF result.

    FIELD-SYMBOLS: <attr>  LIKE LINE OF cl_abap_objectdescr=>attributes,
                   <cache> LIKE LINE OF mt_name_mappings,
                   <field> TYPE any.

    LOOP AT type_descr->attributes ASSIGNING <attr>
      WHERE is_constant IS INITIAL AND alias_for IS INITIAL
      AND ( is_interface IS INITIAL OR type_kind NE cl_abap_typedescr=>typekind_intf ).
      ASSIGN object->(<attr>-name) TO <field>.
      " we can assign to public attributes or to protected and private for friend classes
      CHECK sy-subrc IS INITIAL.
      symb-name = <attr>-name.
      symb-read_only = <attr>-is_read_only.
      symb-type = type_descr->get_attribute_type( <attr>-name ).
      IF symb-type->kind EQ cl_abap_typedescr=>kind_elem.
        symb-elem_type ?= symb-type.
        IF mv_conversion_exits EQ abap_true.
          symb-convexit_in = get_convexit_func( elem_descr = symb-elem_type input = abap_true ).
          symb-convexit_out = get_convexit_func( elem_descr = symb-elem_type input = abap_false ).
        ENDIF.
        symb-typekind = detect_typekind( type_descr = symb-elem_type convexit = symb-convexit_out ).
      ELSE.
        CLEAR: symb-elem_type, symb-typekind.
      ENDIF.
      is_compressable symb-type symb-name symb-compressable.
      GET REFERENCE OF <field> INTO symb-value.
      format_name symb-name mv_pretty_name symb-header.
      CONCATENATE '"' symb-header '":' INTO symb-header.
      IF mv_format_output EQ abap_true.
        CONCATENATE symb-header ' ' INTO symb-header RESPECTING BLANKS.
      ENDIF.
      APPEND symb TO result.
    ENDLOOP.

  ENDMETHOD.                    "GET_SYMBOLS


  METHOD get_symbols_struct.

    DATA: comp_tab     TYPE cl_abap_structdescr=>component_table,
          sym_cache    LIKE result,
          symbol       TYPE t_s_symbol,
          struct_descr TYPE REF TO cl_abap_structdescr,
          struct_cache LIKE LINE OF mt_struct_cache.

    FIELD-SYMBOLS: <comp>   LIKE LINE OF comp_tab,
                   <symbol> LIKE symbol,
                   <cache>  LIKE LINE OF mt_name_mappings,
                   <struct> LIKE LINE OF mt_struct_cache,
                   <data>   TYPE data,
                   <field>  TYPE any.

    READ TABLE mt_struct_cache WITH TABLE KEY type_descr = type_descr include_aliases = include_aliases level = level
    ASSIGNING <struct>.
    IF sy-subrc IS NOT INITIAL.
      struct_cache-type_descr       = type_descr.
      struct_cache-include_aliases  = include_aliases.
      struct_cache-level            = level.

      CREATE DATA struct_cache-result-data TYPE HANDLE type_descr.
      INSERT struct_cache INTO TABLE mt_struct_cache ASSIGNING <struct>.
      ASSIGN <struct>-result-data->* TO <data>.

      comp_tab = type_descr->get_components( ).

      LOOP AT comp_tab ASSIGNING <comp>.
        IF <comp>-name IS NOT INITIAL AND
          ( <comp>-as_include EQ abap_false OR include_aliases EQ abap_true OR mv_expand_includes EQ abap_false ).
          symbol-name = <comp>-name.
          symbol-type = <comp>-type.
          IF symbol-type->kind EQ cl_abap_typedescr=>kind_elem.
            symbol-elem_type ?= symbol-type.
            IF mv_conversion_exits EQ abap_true.
              symbol-convexit_in = get_convexit_func( elem_descr = symbol-elem_type input = abap_true ).
              symbol-convexit_out = get_convexit_func( elem_descr = symbol-elem_type input = abap_false ).
            ENDIF.
            symbol-typekind = detect_typekind( type_descr = symbol-elem_type convexit = symbol-convexit_out ).
          ELSE.
            CLEAR: symbol-elem_type, symbol-typekind.
          ENDIF.
          is_compressable symbol-type symbol-name symbol-compressable.
          ASSIGN COMPONENT symbol-name OF STRUCTURE <data> TO <field>.
          GET REFERENCE OF <field> INTO symbol-value.
          format_name symbol-name mv_pretty_name symbol-header.
          CONCATENATE '"' symbol-header '":' INTO symbol-header.
          IF mv_format_output EQ abap_true.
            CONCATENATE symbol-header ' ' INTO symbol-header RESPECTING BLANKS.
          ENDIF.
          APPEND symbol TO <struct>-result-symbols.
        ENDIF.
        IF <comp>-as_include EQ abap_true AND mv_expand_includes EQ abap_true.
          struct_descr ?= <comp>-type.
          sym_cache = get_symbols_struct( type_descr = struct_descr include_aliases = include_aliases ).
          LOOP AT sym_cache-symbols INTO symbol.
            CONCATENATE symbol-name <comp>-suffix INTO symbol-name.
            IF symbol-type->kind EQ cl_abap_typedescr=>kind_elem.
              symbol-elem_type ?= symbol-type.
              IF mv_conversion_exits EQ abap_true.
                symbol-convexit_in = get_convexit_func( elem_descr = symbol-elem_type input = abap_true ).
                symbol-convexit_out = get_convexit_func( elem_descr = symbol-elem_type input = abap_false ).
              ENDIF.
            ELSE.
              CLEAR symbol-elem_type.
            ENDIF.
            is_compressable symbol-type symbol-name symbol-compressable.
            ASSIGN COMPONENT symbol-name OF STRUCTURE <data> TO <field>.
            GET REFERENCE OF <field> INTO symbol-value.
            format_name symbol-name mv_pretty_name symbol-header.
            CONCATENATE '"' symbol-header '":' INTO symbol-header.
            IF mv_format_output EQ abap_true.
              CONCATENATE symbol-header ' ' INTO symbol-header RESPECTING BLANKS.
            ENDIF.
            APPEND symbol TO <struct>-result-symbols.
          ENDLOOP.
        ENDIF.
      ENDLOOP.
    ENDIF.

    result = <struct>-result.

    IF data IS BOUND AND data NE <struct>-result-data.
      result-data = data.
      ASSIGN data->* TO <data>.
      LOOP AT result-symbols ASSIGNING <symbol>.
        ASSIGN COMPONENT <symbol>-name OF STRUCTURE <data> TO <field>.
        GET REFERENCE OF <field> INTO <symbol>-value.
      ENDLOOP.
    ENDIF.

  ENDMETHOD.                    "GET_SYMBOLS_STRUCT


  METHOD is_compressable.
    rv_compress = abap_true.
  ENDMETHOD.


  METHOD pretty_name.

    DATA: tokens TYPE TABLE OF char128,
          cache  LIKE LINE OF mt_name_mappings.

    FIELD-SYMBOLS: <token> LIKE LINE OF tokens,
                   <cache> LIKE LINE OF mt_name_mappings.

    READ TABLE mt_name_mappings WITH TABLE KEY abap = in ASSIGNING <cache>.
    IF sy-subrc IS INITIAL.
      out = <cache>-json.
    ELSE.
      out = in.

      REPLACE ALL OCCURRENCES OF '__' IN out WITH '*'.

      TRANSLATE out TO LOWER CASE.
      TRANSLATE out USING '/_:_~_'.
      SPLIT out AT '_' INTO TABLE tokens.
      LOOP AT tokens ASSIGNING <token> FROM 2.
        TRANSLATE <token>(1) TO UPPER CASE.
      ENDLOOP.

      CONCATENATE LINES OF tokens INTO out.
      REPLACE ALL OCCURRENCES OF '*' IN out WITH '_'.

      cache-abap  = in.
      cache-json = out.
      INSERT cache INTO TABLE mt_name_mappings.
      INSERT cache INTO TABLE mt_name_mappings_ex.
    ENDIF.

  ENDMETHOD.                    "pretty_name


  METHOD pretty_name_ex.

    DATA: tokens TYPE TABLE OF char128,
          cache  LIKE LINE OF mt_name_mappings.

    FIELD-SYMBOLS: <token> LIKE LINE OF tokens,
                   <cache> LIKE LINE OF mt_name_mappings.

    READ TABLE mt_name_mappings WITH TABLE KEY abap = in ASSIGNING <cache>.
    IF sy-subrc IS INITIAL.
      out = <cache>-json.
    ELSE.
      out = in.


      TRANSLATE out TO LOWER CASE.
      TRANSLATE out USING '/_:_~_'.

      REPLACE ALL OCCURRENCES OF '__e__' IN out WITH '!'.
      REPLACE ALL OCCURRENCES OF '__n__' IN out WITH '#'.
      REPLACE ALL OCCURRENCES OF '__d__' IN out WITH '$'.
      REPLACE ALL OCCURRENCES OF '__p__' IN out WITH '%'.
      REPLACE ALL OCCURRENCES OF '__m__' IN out WITH '&'.
      REPLACE ALL OCCURRENCES OF '__s__' IN out WITH '*'.
      REPLACE ALL OCCURRENCES OF '__h__' IN out WITH '-'.
      REPLACE ALL OCCURRENCES OF '__t__' IN out WITH '~'.
      REPLACE ALL OCCURRENCES OF '__l__' IN out WITH '/'.
      REPLACE ALL OCCURRENCES OF '__c__' IN out WITH ':'.
      REPLACE ALL OCCURRENCES OF '__v__' IN out WITH '|'.
      REPLACE ALL OCCURRENCES OF '__a__' IN out WITH '@'.
      REPLACE ALL OCCURRENCES OF '__o__' IN out WITH '.'.
      REPLACE ALL OCCURRENCES OF '___'   IN out WITH '.'.

      REPLACE ALL OCCURRENCES OF '__' IN out WITH '"'.

      SPLIT out AT '_' INTO TABLE tokens.
      LOOP AT tokens ASSIGNING <token> FROM 2.
        TRANSLATE <token>(1) TO UPPER CASE.
      ENDLOOP.

      CONCATENATE LINES OF tokens INTO out.
      REPLACE ALL OCCURRENCES OF '"' IN out WITH '_'.

      cache-abap  = in.
      cache-json = out.
      INSERT cache INTO TABLE mt_name_mappings.
      INSERT cache INTO TABLE mt_name_mappings_ex.
    ENDIF.

  ENDMETHOD.                    "pretty_name_ex


  METHOD raw_to_string.

    DATA: lv_output_length TYPE i,
          lt_binary_tab    TYPE STANDARD TABLE OF sdokcntbin.

    CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
      EXPORTING
        buffer        = iv_xstring
      IMPORTING
        output_length = lv_output_length
      TABLES
        binary_tab    = lt_binary_tab.

    CALL FUNCTION 'SCMS_BINARY_TO_STRING'
      EXPORTING
        input_length  = lv_output_length
        encoding      = iv_encoding
      IMPORTING
        text_buffer   = rv_string
        output_length = lv_output_length
      TABLES
        binary_tab    = lt_binary_tab
      EXCEPTIONS
        OTHERS        = 10.

    IF sy-subrc IS NOT INITIAL.
      CLEAR rv_string.
    ENDIF.

  ENDMETHOD.


  METHOD restore.

    DATA: mark               LIKE offset,
          match              LIKE offset,
          pos                LIKE offset,
          ref_descr          TYPE REF TO cl_abap_refdescr,
          data_descr         TYPE REF TO cl_abap_datadescr,
          data_ref           TYPE REF TO data,
          object_ref         TYPE REF TO object,
          fields             LIKE field_cache,
          name_json          TYPE string,
          lo_move_cast_error TYPE REF TO cx_sy_move_cast_error,
          source_typename    TYPE string,
          target_typename    TYPE string.

    FIELD-SYMBOLS: <value>       TYPE any,
                   <field_cache> LIKE LINE OF field_cache.

    fields = field_cache.

    IF type_descr IS NOT INITIAL AND type_descr->kind EQ type_descr->kind_ref.
      ref_descr ?= type_descr.
      type_descr = ref_descr->get_referenced_type( ).
      IF ref_descr->type_kind EQ ref_descr->typekind_oref.
        IF data IS INITIAL.
          " can fire an exception, if type is abstract or constructor protected
          CREATE OBJECT data TYPE (type_descr->absolute_name).
        ELSE.
          type_descr = cl_abap_typedescr=>describe_by_object_ref( data ).
        ENDIF.
        object_ref ?= data.
        fields = get_fields( type_descr = type_descr object = object_ref ).
      ELSEIF ref_descr->type_kind EQ ref_descr->typekind_dref.
        IF data IS INITIAL.
          data_descr ?= type_descr.
          CREATE DATA data TYPE HANDLE data_descr.
        ELSE.
          type_descr = cl_abap_typedescr=>describe_by_data_ref( data ).
        ENDIF.
        data_ref ?= data.
        ASSIGN data_ref->* TO <value>.
        fields = get_fields( type_descr = type_descr data = data_ref ).
        restore( EXPORTING json = json length = length type_descr = type_descr field_cache = fields
                   CHANGING data = <value> offset = offset ).
        RETURN.
      ENDIF.
    ENDIF.

    IF fields IS INITIAL AND type_descr IS NOT INITIAL AND type_descr->kind EQ type_descr->kind_struct.
      GET REFERENCE OF data INTO data_ref.
      fields = get_fields( type_descr = type_descr data = data_ref ).
    ENDIF.

    eat_white.
    eat_char '{'.
    eat_white.

    WHILE offset < length AND json+offset(1) NE '}'.

      eat_name name_json.

      TRY.
          eat_white.
          eat_char ':'.
          eat_white.

          READ TABLE fields WITH TABLE KEY name = name_json ASSIGNING <field_cache>.
          IF sy-subrc IS NOT INITIAL.
            TRANSLATE name_json TO UPPER CASE.
            READ TABLE fields WITH TABLE KEY name = name_json ASSIGNING <field_cache>.
          ENDIF.

          IF sy-subrc IS INITIAL.
            ASSIGN <field_cache>-value->* TO <value>.
            restore_type( EXPORTING json = json length = length type_descr = <field_cache>-type convexit = <field_cache>-convexit_in CHANGING data = <value> offset = offset ).
          ELSE.
            restore_type( EXPORTING json = json length = length CHANGING offset = offset ).
          ENDIF.

          eat_white.

          IF offset < length AND json+offset(1) NE '}'.
            eat_char ','.
            eat_white.
          ELSE.
            EXIT.
          ENDIF.

        CATCH cx_sy_move_cast_error INTO lo_move_cast_error.
          IF lo_move_cast_error->source_typename IS NOT INITIAL AND lo_move_cast_error->source_typename(1) <> `[`.
            source_typename = name_json && |.| && lo_move_cast_error->source_typename.
          ELSE.
            source_typename = name_json && lo_move_cast_error->source_typename.
          ENDIF.

          IF lo_move_cast_error->target_typename IS NOT INITIAL.
            target_typename = lo_move_cast_error->target_typename.
          ELSEIF <field_cache> IS ASSIGNED.
            target_typename = lcl_util=>describe_type( <field_cache>-type ).
          ELSE.
            target_typename = `?`.
          ENDIF.

          RAISE EXCEPTION TYPE cx_sy_move_cast_error
            EXPORTING
              previous        = lo_move_cast_error
              source_typename = source_typename
              target_typename = target_typename.
      ENDTRY.

    ENDWHILE.

    eat_char '}'.

  ENDMETHOD.                    "restore


  METHOD restore_type.

    DATA: mark               LIKE offset,
          match              LIKE offset,
          sdummy             TYPE string,                   "#EC NEEDED
          rdummy             TYPE REF TO data,              "#EC NEEDED
          pos                LIKE offset,
          line               TYPE REF TO data,
          key_ref            TYPE REF TO data,
          data_ref           TYPE REF TO data,
          key_name           TYPE string,
          key_value          TYPE string,
          lt_fields          LIKE field_cache,
          ls_symbols         TYPE t_s_struct_cache_res,
          lv_ticks           TYPE string,
          lv_offset          TYPE string,
          lv_convexit        LIKE convexit,
          lo_exp             TYPE REF TO cx_root,
          elem_descr         TYPE REF TO cl_abap_elemdescr,
          table_descr        TYPE REF TO cl_abap_tabledescr,
          struct_descr       TYPE REF TO cl_abap_structdescr,
          ref_descr          TYPE REF TO cl_abap_refdescr,
          data_descr         TYPE REF TO cl_abap_datadescr,
          array_index        TYPE i,
          tstml              TYPE timestampl,
          date               TYPE c LENGTH 8,
          time               TYPE c LENGTH 6,
          guid               TYPE c LENGTH 32,
          lo_move_cast_error TYPE REF TO cx_sy_move_cast_error,
          source_typename    TYPE string,
          target_typename    TYPE string.

    FIELD-SYMBOLS: <line>      TYPE any,
                   <value>     TYPE any,
                   <data>      TYPE data,
                   <field>     LIKE LINE OF lt_fields,
                   <table>     TYPE ANY TABLE,
                   <value_sym> TYPE t_s_symbol.

    lv_convexit = convexit.

    IF type_descr IS INITIAL AND data IS SUPPLIED.
      type_descr = cl_abap_typedescr=>describe_by_data( data ).
      IF mv_conversion_exits EQ abap_true AND lv_convexit IS INITIAL AND type_descr->kind EQ cl_abap_typedescr=>kind_elem.
        elem_descr ?= type_descr.
        lv_convexit = get_convexit_func( elem_descr = elem_descr input = abap_true ).
      ENDIF.
    ENDIF.

    eat_white.

    TRY .
        IF data IS SUPPLIED AND type_descr->absolute_name EQ mc_json_type.
          " skip deserialization
          mark = offset.
          restore_type( EXPORTING json = json length = length CHANGING offset = offset ).
          match = offset - mark.
          data = json+mark(match).
        ELSE.
          CASE json+offset(1).
            WHEN '{'. " object
              IF data IS SUPPLIED.
                IF mv_assoc_arrays EQ c_bool-true AND type_descr->kind EQ cl_abap_typedescr=>kind_table.
                  table_descr ?= type_descr.
                  data_descr = table_descr->get_table_line_type( ).
                  IF table_descr->has_unique_key IS NOT INITIAL.
                    eat_char '{'.
                    eat_white.
                    IF json+offset(1) NE '}'.
                      ASSIGN data TO <table>.
                      CLEAR <table>.
                      CREATE DATA line LIKE LINE OF <table>.
                      ASSIGN line->* TO <line>.
                      lt_fields = get_fields( type_descr = data_descr data = line ).
                      IF table_descr->key_defkind EQ table_descr->keydefkind_user AND lines( table_descr->key ) EQ 1.
                        READ TABLE table_descr->key INDEX 1 INTO key_name.
                        READ TABLE lt_fields WITH TABLE KEY name = key_name ASSIGNING <field>.
                        key_ref = <field>-value.
                        IF mv_assoc_arrays_opt EQ c_bool-true.
                          struct_descr ?= data_descr.
                          ls_symbols = get_symbols_struct( type_descr = struct_descr data = line ).
                          DELETE ls_symbols-symbols WHERE name EQ key_name.
                          IF lines( ls_symbols-symbols ) EQ 1.
                            READ TABLE ls_symbols-symbols INDEX 1 ASSIGNING <value_sym>.
                          ENDIF.
                        ENDIF.
                      ENDIF.
                      eat_white.
                      WHILE offset < length AND json+offset(1) NE '}'.
                        CLEAR <line>.
                        eat_name key_value.
                        eat_white.
                        eat_char ':'.
                        eat_white.
                        IF <value_sym> IS ASSIGNED.
                          ASSIGN <value_sym>-value->* TO <value>.
                          restore_type( EXPORTING json = json length = length type_descr = <value_sym>-type convexit = <value_sym>-convexit_in
                                        CHANGING data = <value> offset = offset ).
                        ELSE.
                          restore_type( EXPORTING json = json length = length type_descr = data_descr field_cache = lt_fields
                                        CHANGING data = <line> offset = offset ).
                        ENDIF.
                        IF table_descr->key_defkind EQ table_descr->keydefkind_user.
                          IF key_ref IS BOUND.
                            ASSIGN key_ref->* TO <value>.
                            IF <value> IS INITIAL.
                              <value> = key_value.
                            ENDIF.
                          ENDIF.
                        ELSEIF <line> IS INITIAL.
                          <line> = key_value.
                        ENDIF.

                        INSERT <line> INTO TABLE <table>.
                        eat_white.
                        IF offset < length AND json+offset(1) NE '}'.
                          eat_char ','.
                          eat_white.
                        ELSE.
                          EXIT.
                        ENDIF.
                      ENDWHILE.
                    ELSE.
                      CLEAR data.
                    ENDIF.
                    eat_char '}'.
                  ELSE.
                    restore( EXPORTING json = json length = length CHANGING  offset = offset ).
                  ENDIF.
                ELSEIF type_descr->type_kind EQ cl_abap_typedescr=>typekind_dref.
                  IF data IS INITIAL.
                    ref_descr ?= type_descr.
                    data_descr ?= ref_descr->get_referenced_type( ).
                    IF data_descr->type_kind EQ data_descr->typekind_data. " REF TO DATA
                      generate_int_ex( EXPORTING json = json length = length CHANGING offset = offset data = data ).
                    ELSEIF data_descr->kind NE data_descr->kind_elem.
                      restore( EXPORTING json = json length = length type_descr = type_descr field_cache = field_cache
                               CHANGING data = data offset = offset ).
                    ELSE. " invlaid type - skip
                      restore( EXPORTING json = json length = length CHANGING offset = offset ).
                    ENDIF.
                  ELSE.
                    data_ref ?= data.
                    type_descr = cl_abap_typedescr=>describe_by_data_ref( data_ref ).
                    ASSIGN data_ref->* TO <data>.
                    restore_type( EXPORTING json = json length = length type_descr = type_descr CHANGING data = <data> offset = offset ).
                  ENDIF.
                ELSE.
                  restore( EXPORTING json = json length = length type_descr = type_descr field_cache = field_cache
                           CHANGING data = data offset = offset ).
                ENDIF.
              ELSE.
                restore( EXPORTING json = json length = length CHANGING  offset = offset ).
              ENDIF.
            WHEN '['. " array
              IF data IS SUPPLIED AND type_descr->type_kind EQ cl_abap_typedescr=>typekind_dref.
                IF data IS INITIAL.
                  ref_descr ?= type_descr.
                  data_descr ?= ref_descr->get_referenced_type( ).
                  IF data_descr->type_kind EQ data_descr->typekind_data. " REF TO DATA
                    generate_int_ex( EXPORTING json = json length = length CHANGING offset = offset data = data ).
                  ELSEIF data_descr->kind EQ data_descr->kind_table. " deserialize in typed table
                    CREATE DATA data TYPE HANDLE data_descr.
                    data_ref ?= data.
                    ASSIGN data_ref->* TO <data>.
                    restore_type( EXPORTING json = json length = length type_descr = data_descr CHANGING data = <data> offset = offset ).
                  ELSE. "invlaid type - skip
                    restore_type( EXPORTING json = json length = length CHANGING offset = offset ).
                  ENDIF.
                ELSE.
                  data_ref ?= data.
                  type_descr = cl_abap_typedescr=>describe_by_data_ref( data_ref ).
                  ASSIGN data_ref->* TO <data>.
                  restore_type( EXPORTING json = json length = length type_descr = type_descr CHANGING data = <data> offset = offset ).
                ENDIF.
              ELSE.
                eat_char '['.
                eat_white.
                IF json+offset(1) NE ']'.
                  IF data IS SUPPLIED AND type_descr->kind EQ cl_abap_typedescr=>kind_table.
                    table_descr ?= type_descr.
                    data_descr = table_descr->get_table_line_type( ).
                    ASSIGN data TO <table>.
                    CLEAR <table>.
                    CREATE DATA line LIKE LINE OF <table>.
                    ASSIGN line->* TO <line>.
                    lt_fields = get_fields( type_descr = data_descr data = line ).
                    array_index = 0.
                    WHILE offset < length AND json+offset(1) NE ']'.
                      array_index = sy-index.
                      CLEAR <line>.
                      restore_type( EXPORTING json = json length = length type_descr = data_descr field_cache = lt_fields
                                    CHANGING data = <line> offset = offset ).
                      INSERT <line> INTO TABLE <table>.
                      eat_white.
                      IF offset < length AND json+offset(1) NE ']'.
                        eat_char ','.
                        eat_white.
                      ELSE.
                        EXIT.
                      ENDIF.
                    ENDWHILE.
                  ELSE.
                    " skip array
                    eat_white.
                    WHILE offset < length AND json+offset(1) NE ']'.
                      restore_type( EXPORTING json = json length = length CHANGING offset = offset ).
                      eat_white.
                      IF offset < length AND json+offset(1) NE ']'.
                        eat_char ','.
                        eat_white.
                      ELSE.
                        EXIT.
                      ENDIF.
                    ENDWHILE.
                    IF data IS SUPPLIED. " JSON to ABAP type match error
                      eat_char ']'.
                      throw_error.
                    ENDIF.
                  ENDIF.
                ELSEIF data IS SUPPLIED.
                  CLEAR data.
                ENDIF.
                eat_char ']'.
              ENDIF.
            WHEN '"'. " string
              IF data IS SUPPLIED.
                IF type_descr->type_kind EQ cl_abap_typedescr=>typekind_dref.
                  restore_reference_ex data type_descr.
                ELSE.
                  eat_name sdummy.
                  IF sdummy IS NOT INITIAL.
                    " unescaped singe characters, e.g \\, \", \/ etc,
                    FIND FIRST OCCURRENCE OF '\' IN sdummy MATCH OFFSET mark.
                    IF sy-subrc IS INITIAL.
                      sdummy = unescape( escaped = sdummy offset = mark ).
                    ENDIF.
                    IF type_descr->kind EQ cl_abap_typedescr=>kind_elem.

                      IF lv_convexit IS NOT INITIAL.
                        TRY .
                            CALL FUNCTION lv_convexit
                              EXPORTING
                                input  = sdummy
                              IMPORTING
                                output = data
                              EXCEPTIONS
                                OTHERS = 1.
                            IF sy-subrc IS NOT INITIAL.
                              CLEAR data.
                            ENDIF.
                            RETURN.
                          CATCH cx_root ##CATCH_ALL ##NO_HANDLER.
                        ENDTRY.
                      ENDIF.

                      CASE type_descr->type_kind.
                        WHEN cl_abap_typedescr=>typekind_char.
                          elem_descr ?= type_descr.
                          IF elem_descr->output_length EQ 1 AND mv_bool_types CS type_descr->absolute_name.
                            IF sdummy(1) CA 'XxTt1'.
                              data = c_bool-true.
                            ELSE.
                              data = c_bool-false.
                            ENDIF.
                            RETURN.
                          ENDIF.
                        WHEN cl_abap_typedescr=>typekind_xstring.
                          string_to_xstring_int sdummy data.
                          RETURN.
                        WHEN cl_abap_typedescr=>typekind_hex.
                          " support for Edm.Guid
                          FIND FIRST OCCURRENCE OF REGEX so_regex_guid IN sdummy SUBMATCHES guid guid+8 guid+12 guid+16 guid+20.
                          IF sy-subrc EQ 0.
                            TRANSLATE guid TO UPPER CASE.
                            data = guid.
                          ELSE.
                            string_to_xstring_int sdummy data.
                          ENDIF.
                          RETURN.
                        WHEN cl_abap_typedescr=>typekind_date.
                          FIND FIRST OCCURRENCE OF REGEX so_regex_date IN sdummy SUBMATCHES date date+4 date+6.
                          IF sy-subrc EQ 0. " => ABAP standard
                            data = date.
                            RETURN.
                          ELSE.
                            tstml = lcl_util=>read_iso8601( sdummy ).
                            IF tstml IS NOT INITIAL.
                              CONVERT TIME STAMP tstml TIME ZONE mv_time_zone INTO DATE data.
                              IF sy-subrc IS NOT INITIAL.
                                CLEAR data.
                              ENDIF.
                              RETURN.
                            ELSE.
                              FIND FIRST OCCURRENCE OF REGEX so_regex_edm_date_time IN sdummy SUBMATCHES lv_ticks lv_offset.
                              IF sy-subrc EQ 0. " => Edm.DateTime
                                sdummy = edm_datetime_to_ts( ticks = lv_ticks offset = lv_offset typekind = type_descr->type_kind ).
                              ELSE.
                                REPLACE FIRST OCCURRENCE OF REGEX so_regex_edm_time IN sdummy WITH '$1$2$3' REPLACEMENT LENGTH match.
                                IF sy-subrc EQ 0. " => Edm.Time
                                  sdummy = sdummy(match).
                                ENDIF.
                              ENDIF.
                            ENDIF.
                          ENDIF.
                        WHEN cl_abap_typedescr=>typekind_time.
                          FIND FIRST OCCURRENCE OF REGEX so_regex_time IN sdummy SUBMATCHES time time+2 time+4.
                          IF sy-subrc EQ 0. " => ABAP standard
                            data = time.
                            RETURN.
                          ELSE.
                            tstml = lcl_util=>read_iso8601( sdummy ).
                            IF tstml IS NOT INITIAL.
                              CONVERT TIME STAMP tstml TIME ZONE mv_time_zone INTO TIME data.
                              IF sy-subrc IS NOT INITIAL.
                                CLEAR data.
                              ENDIF.
                              RETURN.
                            ELSE.
                              FIND FIRST OCCURRENCE OF REGEX so_regex_edm_date_time IN sdummy SUBMATCHES lv_ticks lv_offset.
                              IF sy-subrc EQ 0. " => Edm.DateTime
                                sdummy = edm_datetime_to_ts( ticks = lv_ticks offset = lv_offset typekind = type_descr->type_kind ).
                              ELSE.
                                REPLACE FIRST OCCURRENCE OF REGEX so_regex_edm_time IN sdummy WITH '$4$5$6' REPLACEMENT LENGTH match.
                                IF sy-subrc EQ 0. " => Edm.Time
                                  sdummy = sdummy(match).
                                ENDIF.
                              ENDIF.
                            ENDIF.
                          ENDIF.
                        WHEN mc_typekind_utclong.
                          tstml = lcl_util=>read_iso8601( sdummy ).
                          IF tstml IS NOT INITIAL.
                            TRY.
                                CALL METHOD cl_abap_tstmp=>('TSTMP2UTCLONG')
                                  EXPORTING
                                    timestamp = tstml
                                  RECEIVING
                                    utclong   = data.
                                RETURN.
                              CATCH cx_sy_dyn_call_error.
                                throw_error. " Deserialization of UTCLONG is not supported
                            ENDTRY.
                          ELSE.
                            throw_error. " Wrong ISO8601 format
                          ENDIF.
                        WHEN cl_abap_typedescr=>typekind_packed.
                          tstml = lcl_util=>read_iso8601( sdummy ).
                          IF tstml IS NOT INITIAL.
                            data = tstml.
                            RETURN.
                          ELSE.
                            FIND FIRST OCCURRENCE OF REGEX so_regex_edm_date_time IN sdummy SUBMATCHES lv_ticks lv_offset.
                            IF sy-subrc EQ 0. " => Edm.DateTime
                              sdummy = edm_datetime_to_ts( ticks = lv_ticks offset = lv_offset typekind = type_descr->type_kind ).
                            ELSE.
                              REPLACE FIRST OCCURRENCE OF REGEX so_regex_edm_time IN sdummy WITH '$1$2$3$4$5$6.$7' REPLACEMENT LENGTH match.
                              IF sy-subrc EQ 0. " => Edm.Time
                                sdummy = sdummy(match).
                              ENDIF.
                            ENDIF.
                          ENDIF.
                        WHEN 'k'. "cl_abap_typedescr=>typekind_enum
                          TRY.
                              CALL METHOD ('CL_ABAP_XSD')=>('TO_VALUE')
                                EXPORTING
                                  cs  = sdummy
                                CHANGING
                                  val = data.
                              RETURN.
                            CATCH cx_sy_dyn_call_error.
                              throw_error. " Deserialization of enums is not supported
                          ENDTRY.
                      ENDCASE.
                    ELSE.
                      throw_error. " Other wise dumps with OBJECTS_MOVE_NOT_SUPPORTED
                    ENDIF.
                    data = sdummy.
                  ELSEIF type_descr->kind EQ cl_abap_typedescr=>kind_elem.
                    CLEAR data.
                  ELSE.
                    throw_error. " Other wise dumps with OBJECTS_MOVE_NOT_SUPPORTED
                  ENDIF.
                ENDIF.
              ELSE.
                eat_name sdummy.
              ENDIF.
            WHEN '-' OR '0' OR '1' OR '2' OR '3' OR '4' OR '5' OR '6' OR '7' OR '8' OR '9'. " number
              IF data IS SUPPLIED.
                IF type_descr->type_kind EQ cl_abap_typedescr=>typekind_dref.
                  restore_reference_ex data type_descr.
                ELSEIF type_descr->kind EQ type_descr->kind_elem.
                  IF lv_convexit IS NOT INITIAL.
                    TRY .
                        eat_number sdummy.
                        CALL FUNCTION lv_convexit
                          EXPORTING
                            input  = sdummy
                          IMPORTING
                            output = data
                          EXCEPTIONS
                            OTHERS = 1.
                        IF sy-subrc IS NOT INITIAL.
                          CLEAR data.
                        ENDIF.
                        RETURN.
                      CATCH cx_root ##CATCH_ALL ##NO_HANDLER.
                    ENDTRY.
                  ENDIF.
                  eat_number data.
                ELSE.
                  eat_number sdummy.
                  throw_error.
                ENDIF.
              ELSE.
                eat_number sdummy.
              ENDIF.
            WHEN OTHERS. " boolean, e.g true/false/null
              IF data IS SUPPLIED.
                IF type_descr->type_kind EQ cl_abap_typedescr=>typekind_dref.
                  IF json+offset(1) EQ 'n'. " null
                    eat_bool sdummy.
                    CLEAR data.
                  ELSE.
                    restore_reference_ex data type_descr.
                  ENDIF.
                ELSEIF type_descr->kind EQ type_descr->kind_elem.
                  eat_bool data.
                ELSE.
                  eat_bool sdummy.
                  IF json+mark(match) EQ 'null'.
                    CLEAR data.
                  ELSE.
                    throw_error.
                  ENDIF.
                ENDIF.
              ELSE.
                eat_bool sdummy.
              ENDIF.
          ENDCASE.
        ENDIF.
      CATCH cx_sy_move_cast_error INTO lo_move_cast_error.
        " + CX_SY_CONVERSION_NOT_SUPPORTED > 7.54
        CLEAR data.
        IF mv_strict_mode EQ abap_true.

          IF key_value IS NOT INITIAL.
            IF lo_move_cast_error->source_typename IS NOT INITIAL AND lo_move_cast_error->source_typename(1) <> `[`.
              source_typename = key_value && |.| && lo_move_cast_error->source_typename.
            ELSE.
              source_typename = key_value && lo_move_cast_error->source_typename.
            ENDIF.
          ELSEIF array_index > 0.
            IF lo_move_cast_error->source_typename IS NOT INITIAL AND lo_move_cast_error->source_typename(1) <> `[`.
              source_typename = |[{ array_index }]| && |.| && lo_move_cast_error->source_typename.
            ELSE.
              source_typename = |[{ array_index }]| && lo_move_cast_error->source_typename.
            ENDIF.
          ELSE.
            source_typename = lo_move_cast_error->source_typename.
          ENDIF.
          IF lo_move_cast_error->target_typename IS NOT INITIAL.
            target_typename = lo_move_cast_error->target_typename.
          ELSEIF type_descr IS BOUND.
            target_typename = lcl_util=>describe_type( type_descr ).
          ELSE.
            target_typename = `?`.
          ENDIF.

          RAISE EXCEPTION TYPE cx_sy_move_cast_error
            EXPORTING
              previous        = lo_move_cast_error
              source_typename = source_typename
              target_typename = target_typename.

        ENDIF.
      CATCH cx_sy_conversion_no_number cx_sy_conversion_overflow INTO lo_exp.
        " + CX_SY_CONVERSION_NOT_SUPPORTED > 7.54
        CLEAR data.
        IF mv_strict_mode EQ abap_true.
          RAISE EXCEPTION TYPE cx_sy_move_cast_error EXPORTING previous = lo_exp.
        ENDIF.
    ENDTRY.

  ENDMETHOD.                    "restore_type


  METHOD serialize.

    " **********************************************************************
    " Usage examples and documentation can be found on GitHub:
    " https://github.com/SAP/abap-to-json
    " **********************************************************************  "

    CONSTANTS: lc_method TYPE string VALUE `SERIALIZE_INT`.

    DATA: lo_json  TYPE REF TO object.

    CREATE OBJECT lo_json TYPE (mc_me_type)
      EXPORTING
        compress         = compress
        pretty_name      = pretty_name
        name_mappings    = name_mappings
        assoc_arrays     = assoc_arrays
        assoc_arrays_opt = assoc_arrays_opt
        expand_includes  = expand_includes
        numc_as_string   = numc_as_string
        conversion_exits = conversion_exits
        format_output    = format_output
        hex_as_base64    = hex_as_base64
        ts_as_iso8601    = ts_as_iso8601.

    CALL METHOD lo_json->(lc_method)
      EXPORTING
        name       = name
        data       = data
        type_descr = type_descr
      RECEIVING
        r_json     = r_json.

  ENDMETHOD.                    "serialize


  METHOD serialize_int.

    " **********************************************************************
    " Usage examples and documentation can be found on GitHub:
    " https://github.com/SAP/abap-to-json
    " **********************************************************************  "

    DATA: lo_descr      TYPE REF TO cl_abap_typedescr,
          lo_elem_descr TYPE REF TO cl_abap_elemdescr,
          lv_convexit   TYPE string.

    IF type_descr IS INITIAL.
      lo_descr = cl_abap_typedescr=>describe_by_data( data ).
    ELSE.
      lo_descr = type_descr.
    ENDIF.

    IF mv_conversion_exits EQ abap_true AND lo_descr->kind EQ cl_abap_typedescr=>kind_elem.
      lo_elem_descr ?= lo_descr.
      lv_convexit = get_convexit_func( elem_descr = lo_elem_descr input = abap_false ).
    ENDIF.

    r_json = dump_int( data = data type_descr = lo_descr convexit = lv_convexit ).

    IF name IS NOT INITIAL AND ( mv_compress IS INITIAL OR r_json IS NOT INITIAL ).
      CONCATENATE '"' name '":' r_json INTO r_json.
    ENDIF.

  ENDMETHOD.                    "serialize


  METHOD string_to_raw.

    CALL FUNCTION 'SCMS_STRING_TO_XSTRING'
      EXPORTING
        text     = iv_string
        encoding = iv_encoding
      IMPORTING
        buffer   = rv_xstring
      EXCEPTIONS
        OTHERS   = 1.

    IF sy-subrc IS NOT INITIAL.
      CLEAR rv_xstring.
    ENDIF.

  ENDMETHOD.


  METHOD string_to_xstring.

    DATA: lv_xstring TYPE xstring.

    CALL FUNCTION 'SSFC_BASE64_DECODE'
      EXPORTING
        b64data = in
      IMPORTING
        bindata = lv_xstring
      EXCEPTIONS
        OTHERS  = 1.

    IF sy-subrc IS INITIAL.
      out = lv_xstring.
    ELSE.
      out = in.
    ENDIF.

  ENDMETHOD.                    "string_to_xstring


  METHOD tribool_to_bool.
    IF iv_tribool EQ c_tribool-true.
      rv_bool = c_bool-true.
    ELSEIF iv_tribool EQ c_tribool-undefined.
      rv_bool = abap_undefined. " fall back to abap_undefined
    ENDIF.
  ENDMETHOD.                    "TRIBOOL_TO_BOOL


  METHOD unescape.

    DATA: lv_offset          TYPE i,
          lv_match           TYPE i,
          lv_delta           TYPE i,
          lv_length          TYPE i,
          lv_offset_e        TYPE i,
          lv_length_e        TYPE i,
          lv_unicode_symb    TYPE c,
          lv_unicode_escaped TYPE string,
          lt_matches         TYPE match_result_tab.

    FIELD-SYMBOLS: <match> LIKE LINE OF lt_matches.

    " see reference for escaping rules in JSON RFC
    " https://www.ietf.org/rfc/rfc4627.txt

    unescaped = escaped.
    lv_offset = offset.

    FIND FIRST OCCURRENCE OF '\\' IN unescaped+offset RESPECTING CASE.
    IF sy-subrc IS INITIAL. " complex case - there are escaped "\"

      FIND ALL OCCURRENCES OF REGEX so_regex_unescape_spec_char IN SECTION OFFSET offset OF unescaped RESULTS lt_matches.
      IF sy-subrc IS INITIAL.
        lv_length = strlen( unescaped ).
        LOOP AT lt_matches ASSIGNING <match>.
          lv_match  = <match>-offset - lv_delta.
          lv_offset = lv_match + 1.
          CASE unescaped+lv_offset(1).
            WHEN 'r'.
              REPLACE SECTION OFFSET lv_match LENGTH 2 OF unescaped WITH cl_abap_char_utilities=>cr_lf(1).
              lv_delta = lv_delta + 1.
            WHEN 'n'.
              REPLACE SECTION OFFSET lv_match LENGTH 2 OF unescaped WITH cl_abap_char_utilities=>newline.
              lv_delta = lv_delta + 1.
            WHEN 't'.
              REPLACE SECTION OFFSET lv_match LENGTH 2 OF unescaped WITH cl_abap_char_utilities=>horizontal_tab.
              lv_delta = lv_delta + 1.
            WHEN 'f'.
              REPLACE SECTION OFFSET lv_match LENGTH 2 OF unescaped WITH cl_abap_char_utilities=>form_feed.
              lv_delta = lv_delta + 1.
            WHEN 'b'.
              REPLACE SECTION OFFSET lv_match LENGTH 2 OF unescaped WITH cl_abap_char_utilities=>backspace.
              lv_delta = lv_delta + 1.
            WHEN 'u'.
              lv_offset   = lv_offset + 1.
              lv_offset_e = lv_offset + 4.
              lv_length_e = lv_length + lv_delta.
              IF lv_offset_e LE lv_length_e.
                lv_unicode_escaped = unescaped+lv_offset(4).
                TRANSLATE lv_unicode_escaped TO UPPER CASE.
                lv_unicode_symb = cl_abap_conv_in_ce=>uccp( lv_unicode_escaped ).
                IF lv_unicode_symb NE mc_cov_error OR lv_unicode_escaped EQ '0000'.
                  REPLACE SECTION OFFSET lv_match LENGTH 6 OF unescaped WITH lv_unicode_symb.
                  lv_delta = lv_delta + 5.
                ENDIF.
              ENDIF.
          ENDCASE.
        ENDLOOP.
      ENDIF.

    ELSE. " easy case, we can go with plain text replace

      REPLACE ALL OCCURRENCES OF '\r' IN SECTION OFFSET offset OF unescaped WITH cl_abap_char_utilities=>cr_lf(1).
      REPLACE ALL OCCURRENCES OF '\n' IN SECTION OFFSET offset OF unescaped WITH cl_abap_char_utilities=>newline.
      REPLACE ALL OCCURRENCES OF '\t' IN SECTION OFFSET offset OF unescaped WITH cl_abap_char_utilities=>horizontal_tab.
      REPLACE ALL OCCURRENCES OF '\f' IN SECTION OFFSET offset OF unescaped WITH cl_abap_char_utilities=>form_feed.
      REPLACE ALL OCCURRENCES OF '\b' IN SECTION OFFSET offset OF unescaped WITH cl_abap_char_utilities=>backspace.

      FIND ALL OCCURRENCES OF '\u' IN SECTION OFFSET offset OF unescaped RESULTS lt_matches.
      IF sy-subrc IS INITIAL.
        lv_length = strlen( unescaped ).
        LOOP AT lt_matches ASSIGNING <match>.
          lv_match  = <match>-offset - lv_delta.
          lv_offset = lv_match + 1.
          IF unescaped+lv_offset(1) EQ 'u'.
            lv_offset   = lv_offset + 1.
            lv_offset_e = lv_offset + 4.
            lv_length_e = lv_length + lv_delta.
            IF lv_offset_e LE lv_length_e.
              lv_unicode_escaped = unescaped+lv_offset(4).
              TRANSLATE lv_unicode_escaped TO UPPER CASE.
              lv_unicode_symb = cl_abap_conv_in_ce=>uccp( lv_unicode_escaped ).
              IF lv_unicode_symb NE mc_cov_error OR lv_unicode_escaped EQ '0000'.
                REPLACE SECTION OFFSET lv_match LENGTH 6 OF unescaped WITH lv_unicode_symb.
                lv_delta = lv_delta + 5.
              ENDIF.
            ENDIF.
          ENDIF.
        ENDLOOP.
      ENDIF.

    ENDIF.

    " based on RFC mentioned above, _any_ character can be escaped, and so shall be unenscaped
    " the only exception is Unicode symbols, that shall be kept untouched, while serializer does not handle them
    " unescaped singe characters, e.g \\, \", \/ etc
    REPLACE ALL OCCURRENCES OF REGEX '\\(.)' IN SECTION OFFSET offset OF unescaped WITH '$1' ##REGEX_POSIX ##NO_TEXT.

  ENDMETHOD.


  METHOD xstring_to_string.

    DATA: lv_xstring TYPE xstring.

    " let us fix data conversion issues here
    lv_xstring = in.

    CALL FUNCTION 'SSFC_BASE64_ENCODE'
      EXPORTING
        bindata = lv_xstring
      IMPORTING
        b64data = out
      EXCEPTIONS
        OTHERS  = 1.

    IF sy-subrc IS NOT INITIAL.
      out = in.
    ENDIF.

  ENDMETHOD.                    "xstring_to_string


  METHOD detect_typekind.

    DATA: domain_name     TYPE domname,
          inner_elemdescr TYPE REF TO cl_abap_elemdescr.

    IF convexit IS NOT INITIAL.
      rv_type = e_typekind-convexit.
    ELSE.
      rv_type = type_descr->type_kind.
      IF rv_type EQ cl_abap_typedescr=>typekind_packed AND mv_ts_as_iso8601 EQ c_bool-true.

        IF type_descr->help_id IS NOT INITIAL AND NOT contains( val = type_descr->absolute_name end = type_descr->help_id ).
          TRY.
              inner_elemdescr ?= cl_abap_elemdescr=>describe_by_name( type_descr->help_id ).
              IF inner_elemdescr->is_ddic_type( ) EQ abap_true.
                domain_name = inner_elemdescr->get_ddic_field( )-domname.
              ENDIF.
            CATCH cx_root.                               "#EC CATCH_ALL
              domain_name = ''.
          ENDTRY.
        ELSE.
          IF type_descr->is_ddic_type( ) EQ abap_true.
            domain_name = type_descr->get_ddic_field( )-domname.
          ENDIF.
        ENDIF.

        IF domain_name EQ 'TZNTSTMPS' OR domain_name EQ 'XSDDATETIME_Z'. " domain of TIMESTAMP is TZNTSTMPS
          rv_type = e_typekind-ts_iso8601.
        ELSEIF domain_name EQ 'TZNTSTMPL' OR domain_name EQ 'XSDDATETIME_LONG_Z'.
          rv_type = e_typekind-tsl_iso8601.
        ENDIF.

      ELSEIF rv_type EQ cl_abap_typedescr=>typekind_num AND mv_numc_as_string EQ abap_true.
        rv_type = e_typekind-numc_string.
      ELSEIF rv_type EQ cl_abap_typedescr=>typekind_string AND type_descr->absolute_name EQ mc_json_type.
        rv_type = e_typekind-json.
      ELSEIF rv_type EQ cl_abap_typedescr=>typekind_char AND type_descr->output_length EQ 1 AND mv_bool_types CS type_descr->absolute_name.
        IF mv_bool_3state CS type_descr->absolute_name.
          rv_type = e_typekind-tribool.
        ELSE.
          rv_type = e_typekind-bool.
        ENDIF.
      ENDIF.
    ENDIF.

  ENDMETHOD.                    "DETECT_EXT_TYPE_KIND
ENDCLASS.
