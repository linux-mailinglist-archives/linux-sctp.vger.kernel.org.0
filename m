Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9EA1C9B99
	for <lists+linux-sctp@lfdr.de>; Thu,  7 May 2020 22:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgEGUEu (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 7 May 2020 16:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGUEt (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 7 May 2020 16:04:49 -0400
Received: from smtp.tuxdriver.com (tunnel92311-pt.tunnel.tserv13.ash1.ipv6.he.net [IPv6:2001:470:7:9c9::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E5DC4C05BD43;
        Thu,  7 May 2020 13:04:48 -0700 (PDT)
Received: from [107.15.85.130] (helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1jWml4-0006aV-S7; Thu, 07 May 2020 16:04:44 -0400
Date:   Thu, 7 May 2020 16:04:33 -0400
From:   Neil Horman <nhorman@tuxdriver.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Vlad Yasevich <vyasevich@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        linux-sctp@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sctp: Replace zero-length array with flexible-array
Message-ID: <20200507200433.GA2838429@hmswarspite.think-freely.org>
References: <20200507192152.GA16230@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507192152.GA16230@embeddedor>
X-Spam-Score: -2.9 (--)
X-Spam-Status: No
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Thu, May 07, 2020 at 02:21:52PM -0500, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> sizeof(flexible-array-member) triggers a warning because flexible array
> members have incomplete type[1]. There are some instances of code in
> which the sizeof operator is being incorrectly/erroneously applied to
> zero-length arrays and the result is zero. Such instances may be hiding
> some bugs. So, this work (flexible-array member conversions) will also
> help to get completely rid of those sorts of issues.
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  include/linux/sctp.h |   36 ++++++++++++++++++------------------
>  1 file changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/include/linux/sctp.h b/include/linux/sctp.h
> index 8ccd82105de8..76731230bbc5 100644
> --- a/include/linux/sctp.h
> +++ b/include/linux/sctp.h
> @@ -221,7 +221,7 @@ struct sctp_datahdr {
>  	__be16 stream;
>  	__be16 ssn;
>  	__u32 ppid;
> -	__u8  payload[0];
> +	__u8  payload[];
>  };
>  
>  struct sctp_data_chunk {
> @@ -269,7 +269,7 @@ struct sctp_inithdr {
>  	__be16 num_outbound_streams;
>  	__be16 num_inbound_streams;
>  	__be32 initial_tsn;
> -	__u8  params[0];
> +	__u8  params[];
>  };
>  
>  struct sctp_init_chunk {
> @@ -299,13 +299,13 @@ struct sctp_cookie_preserve_param {
>  /* Section 3.3.2.1 Host Name Address (11) */
>  struct sctp_hostname_param {
>  	struct sctp_paramhdr param_hdr;
> -	uint8_t hostname[0];
> +	uint8_t hostname[];
>  };
>  
>  /* Section 3.3.2.1 Supported Address Types (12) */
>  struct sctp_supported_addrs_param {
>  	struct sctp_paramhdr param_hdr;
> -	__be16 types[0];
> +	__be16 types[];
>  };
>  
>  /* ADDIP Section 3.2.6 Adaptation Layer Indication */
> @@ -317,25 +317,25 @@ struct sctp_adaptation_ind_param {
>  /* ADDIP Section 4.2.7 Supported Extensions Parameter */
>  struct sctp_supported_ext_param {
>  	struct sctp_paramhdr param_hdr;
> -	__u8 chunks[0];
> +	__u8 chunks[];
>  };
>  
>  /* AUTH Section 3.1 Random */
>  struct sctp_random_param {
>  	struct sctp_paramhdr param_hdr;
> -	__u8 random_val[0];
> +	__u8 random_val[];
>  };
>  
>  /* AUTH Section 3.2 Chunk List */
>  struct sctp_chunks_param {
>  	struct sctp_paramhdr param_hdr;
> -	__u8 chunks[0];
> +	__u8 chunks[];
>  };
>  
>  /* AUTH Section 3.3 HMAC Algorithm */
>  struct sctp_hmac_algo_param {
>  	struct sctp_paramhdr param_hdr;
> -	__be16 hmac_ids[0];
> +	__be16 hmac_ids[];
>  };
>  
>  /* RFC 2960.  Section 3.3.3 Initiation Acknowledgement (INIT ACK) (2):
> @@ -350,7 +350,7 @@ struct sctp_initack_chunk {
>  /* Section 3.3.3.1 State Cookie (7) */
>  struct sctp_cookie_param {
>  	struct sctp_paramhdr p;
> -	__u8 body[0];
> +	__u8 body[];
>  };
>  
>  /* Section 3.3.3.1 Unrecognized Parameters (8) */
> @@ -384,7 +384,7 @@ struct sctp_sackhdr {
>  	__be32 a_rwnd;
>  	__be16 num_gap_ack_blocks;
>  	__be16 num_dup_tsns;
> -	union sctp_sack_variable variable[0];
> +	union sctp_sack_variable variable[];
>  };
>  
>  struct sctp_sack_chunk {
> @@ -436,7 +436,7 @@ struct sctp_shutdown_chunk {
>  struct sctp_errhdr {
>  	__be16 cause;
>  	__be16 length;
> -	__u8  variable[0];
> +	__u8  variable[];
>  };
>  
>  struct sctp_operr_chunk {
> @@ -594,7 +594,7 @@ struct sctp_fwdtsn_skip {
>  
>  struct sctp_fwdtsn_hdr {
>  	__be32 new_cum_tsn;
> -	struct sctp_fwdtsn_skip skip[0];
> +	struct sctp_fwdtsn_skip skip[];
>  };
>  
>  struct sctp_fwdtsn_chunk {
> @@ -611,7 +611,7 @@ struct sctp_ifwdtsn_skip {
>  
>  struct sctp_ifwdtsn_hdr {
>  	__be32 new_cum_tsn;
> -	struct sctp_ifwdtsn_skip skip[0];
> +	struct sctp_ifwdtsn_skip skip[];
>  };
>  
>  struct sctp_ifwdtsn_chunk {
> @@ -658,7 +658,7 @@ struct sctp_addip_param {
>  
>  struct sctp_addiphdr {
>  	__be32	serial;
> -	__u8	params[0];
> +	__u8	params[];
>  };
>  
>  struct sctp_addip_chunk {
> @@ -718,7 +718,7 @@ struct sctp_addip_chunk {
>  struct sctp_authhdr {
>  	__be16 shkey_id;
>  	__be16 hmac_id;
> -	__u8   hmac[0];
> +	__u8   hmac[];
>  };
>  
>  struct sctp_auth_chunk {
> @@ -733,7 +733,7 @@ struct sctp_infox {
>  
>  struct sctp_reconf_chunk {
>  	struct sctp_chunkhdr chunk_hdr;
> -	__u8 params[0];
> +	__u8 params[];
>  };
>  
>  struct sctp_strreset_outreq {
> @@ -741,13 +741,13 @@ struct sctp_strreset_outreq {
>  	__be32 request_seq;
>  	__be32 response_seq;
>  	__be32 send_reset_at_tsn;
> -	__be16 list_of_streams[0];
> +	__be16 list_of_streams[];
>  };
>  
>  struct sctp_strreset_inreq {
>  	struct sctp_paramhdr param_hdr;
>  	__be32 request_seq;
> -	__be16 list_of_streams[0];
> +	__be16 list_of_streams[];
>  };
>  
>  struct sctp_strreset_tsnreq {
> 
> 
Acked-by: Neil Horman <nhorman@redhat.com>
