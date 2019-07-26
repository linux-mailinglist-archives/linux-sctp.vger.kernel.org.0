Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E87A677377
	for <lists+linux-sctp@lfdr.de>; Fri, 26 Jul 2019 23:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbfGZVav (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Fri, 26 Jul 2019 17:30:51 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35229 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbfGZVav (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Fri, 26 Jul 2019 17:30:51 -0400
Received: by mail-qk1-f194.google.com with SMTP id r21so40185965qke.2;
        Fri, 26 Jul 2019 14:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dQjKZe5ZIisB+jYkXsqpcBIwf20hxNpJSx/NJlMHif0=;
        b=Q21lMWLXAlD0/VsF9hm2+zcG1lU0SRB1ZwQAWDPWRCw9KoQF5bwYmn+xiDTVTJDpCw
         s7IblGwlbwy4LoaLSW/jWnUrGJhKnH7LQovEjVlFLWC5NojRTQAdWfA3T3kSrU5EwV4W
         y6zrIObXeZDtlybF6NboB76kTyXP6ctr64HOZ/IQSY3dWkoE7fVckCg88+CQhlCXr9wv
         QLLRNYhpviiqfJamtOGr5Vu9Kq59d30eddZL7TpSy/5zYotuZ4yK/Nw3RvZD1nPlD3qc
         hHJ87YgFeYgt36sWPxg6JRRznN+snz/HOUin6eVS9yy8TpPu/APopZhrBv3Ulh7rafbl
         WUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dQjKZe5ZIisB+jYkXsqpcBIwf20hxNpJSx/NJlMHif0=;
        b=U/2d1t6R0vIcmTRxKeCq7CEvCkGXVcB5wr/h0xcokWUN0Kd8cW0oFWjNH4t9nwpz+g
         UAA4RxgfL0uCCIiwzwaC+rRIhtc/FeCWcDNDfjYNQyWa4L+ddYyFW7Ap/2HCaO0mKY/K
         079kB+GtGemmfMPCM0EOAVbt1vlxLvsTxqDrmGxYOK0lTIhcy6JxIhDH4s+pVT7MVMwS
         gMaoSNiEv2rl6wjtGrDaCwLU7FfZ1lZD2KO5W8b35Lu0qh3BINwGDwEAt0HW0PSa4YM4
         eeIoPDbUmMo8sj7D571Kysi2BQplRGV7x4F2fHP68NzCEbQul6IJRrI9xb0jYOFvsmst
         TtZA==
X-Gm-Message-State: APjAAAUKz2Oxxls7v97DzfNxOCfVSQtGVlQsZDrcubNUBAvkSz/qONDs
        xGQsXZowk6xBbpXPDMJTUcudDSlus6QLlw==
X-Google-Smtp-Source: APXvYqwF6+35DPwztcSKhpZqKSVe9ngRlNV9ZO9T1phUuqhE0jvmwqHgPHBhVScUAq51mV9RPi0OWg==
X-Received: by 2002:a37:c81:: with SMTP id 123mr66357179qkm.474.1564176649379;
        Fri, 26 Jul 2019 14:30:49 -0700 (PDT)
Received: from localhost.localdomain ([168.181.49.45])
        by smtp.gmail.com with ESMTPSA id i62sm24920470qke.52.2019.07.26.14.30.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 14:30:48 -0700 (PDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 02890C1906; Fri, 26 Jul 2019 18:30:45 -0300 (-03)
Date:   Fri, 26 Jul 2019 18:30:45 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Qian Cai <cai@lca.pw>
Cc:     vyasevich@gmail.com, nhorman@tuxdriver.com,
        linux-sctp@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/sctp: fix GCC8+ -Wpacked-not-aligned warnings
Message-ID: <20190726213045.GL6204@localhost.localdomain>
References: <1564174659-21211-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564174659-21211-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Fri, Jul 26, 2019 at 04:57:39PM -0400, Qian Cai wrote:
> There are a lot of those warnings with GCC8+ 64bit,
> 
> In file included from ./include/linux/sctp.h:42,
>                  from net/core/skbuff.c:47:
> ./include/uapi/linux/sctp.h:395:1: warning: alignment 4 of 'struct
> sctp_paddr_change' is less than 8 [-Wpacked-not-aligned]
>  } __attribute__((packed, aligned(4)));
>  ^
> ./include/uapi/linux/sctp.h:728:1: warning: alignment 4 of 'struct
> sctp_setpeerprim' is less than 8 [-Wpacked-not-aligned]
>  } __attribute__((packed, aligned(4)));
>  ^
> ./include/uapi/linux/sctp.h:727:26: warning: 'sspp_addr' offset 4 in
> 'struct sctp_setpeerprim' isn't aligned to 8 [-Wpacked-not-aligned]
>   struct sockaddr_storage sspp_addr;
>                           ^~~~~~~~~
> ./include/uapi/linux/sctp.h:741:1: warning: alignment 4 of 'struct
> sctp_prim' is less than 8 [-Wpacked-not-aligned]
>  } __attribute__((packed, aligned(4)));
>  ^
> ./include/uapi/linux/sctp.h:740:26: warning: 'ssp_addr' offset 4 in
> 'struct sctp_prim' isn't aligned to 8 [-Wpacked-not-aligned]
>   struct sockaddr_storage ssp_addr;
>                           ^~~~~~~~
> ./include/uapi/linux/sctp.h:792:1: warning: alignment 4 of 'struct
> sctp_paddrparams' is less than 8 [-Wpacked-not-aligned]
>  } __attribute__((packed, aligned(4)));
>  ^
> ./include/uapi/linux/sctp.h:784:26: warning: 'spp_address' offset 4 in
> 'struct sctp_paddrparams' isn't aligned to 8 [-Wpacked-not-aligned]
>   struct sockaddr_storage spp_address;
>                           ^~~~~~~~~~~
> ./include/uapi/linux/sctp.h:905:1: warning: alignment 4 of 'struct
> sctp_paddrinfo' is less than 8 [-Wpacked-not-aligned]
>  } __attribute__((packed, aligned(4)));
>  ^
> ./include/uapi/linux/sctp.h:899:26: warning: 'spinfo_address' offset 4
> in 'struct sctp_paddrinfo' isn't aligned to 8 [-Wpacked-not-aligned]
>   struct sockaddr_storage spinfo_address;
>                           ^~~~~~~~~~~~~~
> Fix them by aligning the structures and fields to 8 bytes instead.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  include/uapi/linux/sctp.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/include/uapi/linux/sctp.h b/include/uapi/linux/sctp.h
> index b8f2c4d56532..e7bd71cde882 100644
> --- a/include/uapi/linux/sctp.h
> +++ b/include/uapi/linux/sctp.h

These changes gotta be more careful, if possible at all. As is, it's breaking UAPI.

-before
+after patch

 struct sctp_paddrparams {
        sctp_assoc_t               spp_assoc_id;         /*     0     4 */
-       struct __kernel_sockaddr_storage spp_address __attribute__((__aligned__(1))); /*     4   128 */
-       /* --- cacheline 2 boundary (128 bytes) was 4 bytes ago --- */
-       __u32                      spp_hbinterval;       /*   132     4 */
-       __u16                      spp_pathmaxrxt;       /*   136     2 */
-       __u32                      spp_pathmtu;          /*   138     4 */
-       __u32                      spp_sackdelay;        /*   142     4 */
-       __u32                      spp_flags;            /*   146     4 */
-       __u32                      spp_ipv6_flowlabel;   /*   150     4 */
-       __u8                       spp_dscp;             /*   154     1 */

-       /* size: 156, cachelines: 3, members: 9 */
+       /* XXX 4 bytes hole, try to pack */
+
+       struct __kernel_sockaddr_storage spp_address __attribute__((__aligned__(8))); /*     8   128 */
+       /* --- cacheline 2 boundary (128 bytes) was 8 bytes ago --- */
+       __u32                      spp_hbinterval;       /*   136     4 */
+       __u16                      spp_pathmaxrxt;       /*   140     2 */
+       __u32                      spp_pathmtu;          /*   142     4 */
+       __u32                      spp_sackdelay;        /*   146     4 */
+       __u32                      spp_flags;            /*   150     4 */
+       __u32                      spp_ipv6_flowlabel;   /*   154     4 */
+       __u8                       spp_dscp;             /*   158     1 */
+
+       /* size: 160, cachelines: 3, members: 9 */
+       /* sum members: 155, holes: 1, sum holes: 4 */
        /* padding: 1 */
-       /* forced alignments: 1 */
-       /* last cacheline: 28 bytes */
-} __attribute__((__aligned__(4)));
+       /* forced alignments: 1, forced holes: 1, sum forced holes: 4 */
+       /* last cacheline: 32 bytes */
+} __attribute__((__aligned__(8)));


> @@ -392,7 +392,7 @@ struct sctp_paddr_change {
>  	int spc_state;
>  	int spc_error;
>  	sctp_assoc_t spc_assoc_id;
> -} __attribute__((packed, aligned(4)));
> +} __attribute__((packed, aligned(8)));
>  
>  /*
>   *    spc_state:  32 bits (signed integer)
> @@ -724,8 +724,8 @@ struct sctp_assocparams {
>   */
>  struct sctp_setpeerprim {
>  	sctp_assoc_t            sspp_assoc_id;
> -	struct sockaddr_storage sspp_addr;
> -} __attribute__((packed, aligned(4)));
> +	struct sockaddr_storage sspp_addr __attribute__((aligned(8)));
> +} __attribute__((packed, aligned(8)));
>  
>  /*
>   * 7.1.10 Set Primary Address (SCTP_PRIMARY_ADDR)
> @@ -737,8 +737,8 @@ struct sctp_setpeerprim {
>   */
>  struct sctp_prim {
>  	sctp_assoc_t            ssp_assoc_id;
> -	struct sockaddr_storage ssp_addr;
> -} __attribute__((packed, aligned(4)));
> +	struct sockaddr_storage ssp_addr __attribute__((aligned(8)));
> +} __attribute__((packed, aligned(8)));
>  
>  /* For backward compatibility use, define the old name too */
>  #define sctp_setprim	sctp_prim
> @@ -781,7 +781,7 @@ enum  sctp_spp_flags {
>  
>  struct sctp_paddrparams {
>  	sctp_assoc_t		spp_assoc_id;
> -	struct sockaddr_storage	spp_address;
> +	struct sockaddr_storage	spp_address __attribute__((aligned(8)));
>  	__u32			spp_hbinterval;
>  	__u16			spp_pathmaxrxt;
>  	__u32			spp_pathmtu;
> @@ -789,7 +789,7 @@ struct sctp_paddrparams {
>  	__u32			spp_flags;
>  	__u32			spp_ipv6_flowlabel;
>  	__u8			spp_dscp;
> -} __attribute__((packed, aligned(4)));
> +} __attribute__((packed, aligned(8)));
>  
>  /*
>   * 7.1.18.  Add a chunk that must be authenticated (SCTP_AUTH_CHUNK)
> @@ -896,13 +896,13 @@ struct sctp_stream_value {
>   */
>  struct sctp_paddrinfo {
>  	sctp_assoc_t		spinfo_assoc_id;
> -	struct sockaddr_storage	spinfo_address;
> +	struct sockaddr_storage	spinfo_address __attribute__((aligned(8)));
>  	__s32			spinfo_state;
>  	__u32			spinfo_cwnd;
>  	__u32			spinfo_srtt;
>  	__u32			spinfo_rto;
>  	__u32			spinfo_mtu;
> -} __attribute__((packed, aligned(4)));
> +} __attribute__((packed, aligned(8)));
>  
>  /* Peer addresses's state. */
>  /* UNKNOWN: Peer address passed by the upper layer in sendmsg or connect[x]
> -- 
> 1.8.3.1
> 
