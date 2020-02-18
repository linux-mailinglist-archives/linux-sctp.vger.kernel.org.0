Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBF19161F98
	for <lists+linux-sctp@lfdr.de>; Tue, 18 Feb 2020 04:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgBRDkG (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 17 Feb 2020 22:40:06 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36964 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgBRDkG (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 17 Feb 2020 22:40:06 -0500
Received: by mail-qk1-f193.google.com with SMTP id c188so18260840qkg.4
        for <linux-sctp@vger.kernel.org>; Mon, 17 Feb 2020 19:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QZe1o9TjqCsXgk2J5UgWU3LfAybwmptLr8cehPw+ass=;
        b=bsBjv1Y1s5T5xnav4twa72xJjDN02MSNDMb9GmwVFnk3pOgdNCaXwKhiyFCesujzlR
         tsTBVO+spyPfROSaRjBFVjbBAJzBvp/i3U5JAmx8qracxFwMaGTlMiTm+k8O9KeQhcCs
         JuiCtvjHjxoY9cE3mbsF/s7Xf0a21I7ydCclkC2245U9BnO6bp72n4N1er9YafVkU0fW
         J6K+iVgvPvX3nD65qSWzFVXaMLJlWV7OlSKVZRUAxtMEDaM6nG3EdEVpy1aXVAj5Zh8p
         QrFXvetV6Lp1hQ7puNo0kO2qrpoYFGwX4X4cfBi9DiEQO7zXXVc7GkwOnwIo7aSZ52Oo
         OTJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QZe1o9TjqCsXgk2J5UgWU3LfAybwmptLr8cehPw+ass=;
        b=CXVTvzzWZgO2Y3+Y5AQPwOKQEG6IdXVWcgnf/E1Z9TxvDGWxrLys/NkaHsvGhIqoXb
         baDI5uEQ1cCO6UTjO6eZt09RDlRo/vuMaYAvEgG5pkTtpsiX8t4xm3BvG4HHGAI4R8Fj
         0lym5Sjehei75ENoI/tlRHpRoEYp2Li/rl03PE+jq7VsmuEwKVNY6ZhOpuji1F3FH1vD
         bZWDVWZ5QT1tJsnndgR/RS2nCdNbwZgWRSz9jXjOPu5t9KSpT4NbftIqI0rPibHa699n
         e4GKQhGQdlx7D3FY3xDfIe2g1un9RWc33VdnSrSB7ar14n8kr3Dvv1vqXkt8ZmwJl786
         FWYQ==
X-Gm-Message-State: APjAAAUvPttECLTre9GpxRZBL/yPHdC+LlFaFyB3iZoM0yYzlnCwrzbB
        G1+71aZkEr7FtDTYgetBJH4O5NrYffk=
X-Google-Smtp-Source: APXvYqxf5Y0NdscWJrpf+SUzsQtbAkIuN67CCALQCk0eIoSNnkgdFgaUTo6EOIKpT+0ERNlHyEoZow==
X-Received: by 2002:a37:4891:: with SMTP id v139mr17347319qka.172.1581997204740;
        Mon, 17 Feb 2020 19:40:04 -0800 (PST)
Received: from localhost.localdomain ([168.181.48.223])
        by smtp.gmail.com with ESMTPSA id w202sm1305404qkb.89.2020.02.17.19.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 19:40:03 -0800 (PST)
Received: by localhost.localdomain (Postfix, from userid 1000)
        id 2A404C0DD6; Tue, 18 Feb 2020 00:40:01 -0300 (-03)
Date:   Tue, 18 Feb 2020 00:40:01 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     "Fan, Jessie (NSB - CN/Qingdao)" <jessie.fan@nokia-sbell.com>
Cc:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>,
        "dajiang.zhang@nokia.com" <dajiang.zhang@nokia.com>,
        "piggy@acm.org" <piggy@acm.org>,
        "karl@athena.chicago.il.us" <karl@athena.chicago.il.us>,
        "chris@hundredacre.ac.uk" <chris@hundredacre.ac.uk>,
        "jgrimm@us.ibm.com" <jgrimm@us.ibm.com>,
        "xingang.guo@intel.com" <xingang.guo@intel.com>,
        "sri@us.ibm.com" <sri@us.ibm.com>,
        "daisyc@us.ibm.com" <daisyc@us.ibm.com>,
        "ardelle.fan@intel.com" <ardelle.fan@intel.com>,
        "kevin.gao@intel.com" <kevin.gao@intel.com>,
        "Chen, Chris A. (NSB - CN/Qingdao)" <chris.a.chen@nokia-sbell.com>
Subject: Re: v5.3.12 SCTP Stream Negotiation Problem
Message-ID: <20200218034001.GA2547@localhost.localdomain>
References: <9c353cef257847c7b64793d3839abc33@nokia-sbell.com>
 <29c18e4a424343bab0fea1904cfae492@nokia-sbell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29c18e4a424343bab0fea1904cfae492@nokia-sbell.com>
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi,

On Tue, Feb 18, 2020 at 12:37:17AM +0000, Fan, Jessie (NSB - CN/Qingdao) wrote:
> Hi, 
> 
> I found the SCTP Stream negotiation doesn't work as expected, that is, the local outbound stream and the remote inbound stream comparison seems missing.
> For example, when the local outstream(16) is greater than the remote inbound stream(2), 16 is saved and used as the "OUTS", which is shown from /proc/pid/net/sctp/assocs below.
> Can anyone help comment?
> 
> From local end point, 16 is set as both the outbound and inbound stream.
> From the remote end point, 2 is set for both the outbound and inbound stream
> 
> However, after the association is up, the inbound and outbound stream is set as (2,16), which I think is unexpected.
> sh-4.2# cat 1/net/sctp/assocs
> ASSOC SOCK STY SST ST HBKT ASSOC-ID TX_QUEUE RX_QUEUE UID INODE LPORT RPORT LADDRS <-> RADDRS HBINT INS OUTS MAXRT T1X T2X RTXC wmema wmemq sndbuf rcvbuf
> 55dae5bb bb3dec72 0 7 3 0 2415 0 0 504 1223451 2905 3904 xx.xx.xx.xx yy.yy.yy.yy <-> *zz.zz.zz.zz ww.ww.ww.ww 30000 2 16 10 0 0 0 1 0 262144 262144
> 
> I further checked the kernel code and found in v5.0, there is still comparison logic: min(outcnt, stream->outcnt) and save the smaller one in the function sctp_stream_alloc_out().
> But the logic disappeared in v5.1, and if the "outcnt" is smaller, it's not saved locally.
> static int sctp_stream_alloc_out(struct sctp_stream *stream, __u16 outcnt,
>                                 gfp_t gfp)
> {
>         int ret;
> 
>         if (outcnt <= stream->outcnt) //Here is problematic, and the outcnt is not saved locally.

Makes sense.
Before 2075e50caf5e ("sctp: convert to genradix") it was updating
stream->outcnt with smaller values when applicable:

-       if (outcnt > stream->outcnt)
-               fa_zero(out, stream->outcnt, (outcnt - stream->outcnt));
+       if (outcnt <= stream->outcnt)
+               return 0;

-       stream->out = out;

It also affects the input stream AFAICT.
Can you please try the following patch?

Thanks,
Marcelo

---8<---

diff --git a/net/sctp/stream.c b/net/sctp/stream.c
index 67f7e71f9129..34f0b7312fe8 100644
--- a/net/sctp/stream.c
+++ b/net/sctp/stream.c
@@ -81,12 +81,13 @@ static int sctp_stream_alloc_out(struct sctp_stream *stream, __u16 outcnt,
 	int ret;
 
 	if (outcnt <= stream->outcnt)
-		return 0;
+		goto out;
 
 	ret = genradix_prealloc(&stream->out, outcnt, gfp);
 	if (ret)
 		return ret;
 
+out:
 	stream->outcnt = outcnt;
 	return 0;
 }
@@ -96,13 +97,14 @@ static int sctp_stream_alloc_in(struct sctp_stream *stream, __u16 incnt,
 {
 	int ret;
 
-	if (incnt <= stream->incnt)
-		return 0;
+	if (incnt > stream->incnt)
+		goto out;
 
 	ret = genradix_prealloc(&stream->in, incnt, gfp);
 	if (ret)
 		return ret;
 
+out:
 	stream->incnt = incnt;
 	return 0;
 }
