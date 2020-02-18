Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 389CF161E36
	for <lists+linux-sctp@lfdr.de>; Tue, 18 Feb 2020 01:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgBRAhZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Mon, 17 Feb 2020 19:37:25 -0500
Received: from cnshjsmin05.app.nokia-sbell.com ([116.246.26.45]:19832 "EHLO
        cnshjsmin05.nokia-sbell.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725997AbgBRAhZ (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>);
        Mon, 17 Feb 2020 19:37:25 -0500
X-AuditID: ac18929d-8e32c9c000001441-42-5e4b31c09099
Received: from CNSHPPEXCH1605.nsn-intra.net (Unknown_Domain [135.251.51.105])
        (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by cnshjsmin05.nokia-sbell.com (Symantec Messaging Gateway) with SMTP id F5.37.05185.0C13B4E5; Tue, 18 Feb 2020 08:37:20 +0800 (HKT)
Received: from CNSHPPEXCH1608.nsn-intra.net (135.251.51.108) by
 CNSHPPEXCH1605.nsn-intra.net (135.251.51.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 18 Feb 2020 08:37:17 +0800
Received: from CNSHPPEXCH1608.nsn-intra.net ([135.251.51.108]) by
 CNSHPPEXCH1608.nsn-intra.net ([135.251.51.108]) with mapi id 15.01.1713.007;
 Tue, 18 Feb 2020 08:37:17 +0800
From:   "Fan, Jessie (NSB - CN/Qingdao)" <jessie.fan@nokia-sbell.com>
To:     "linux-sctp@vger.kernel.org" <linux-sctp@vger.kernel.org>
CC:     "dajiang.zhang@nokia.com" <dajiang.zhang@nokia.com>,
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
Subject: RE: v5.3.12 SCTP Stream Negotiation Problem
Thread-Topic: v5.3.12 SCTP Stream Negotiation Problem
Thread-Index: AdXlrLY4UK7/UQp9T1OKdInYOGTdVQARfdhA
Date:   Tue, 18 Feb 2020 00:37:17 +0000
Message-ID: <29c18e4a424343bab0fea1904cfae492@nokia-sbell.com>
References: <9c353cef257847c7b64793d3839abc33@nokia-sbell.com>
In-Reply-To: <9c353cef257847c7b64793d3839abc33@nokia-sbell.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [135.251.51.115]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsXS/ts4U/eAoXecwa0OaYu2pjtsFgv3djNa
        zDuxn8VixuWjTBbdE2YzW+yZuI7F4umC16wW3xrOslssP/mO2eJcWy+TA5fH5SveHjvXvmDy
        uLv4EIvH4j0vmTzOXetj9vi8SS6ALYrLJiU1J7MstUjfLoEr41HvL9aCx7wVx3d/Zm9g3MTV
        xcjJISFgIrFq4nX2LkYuDiGBQ0wSr2+3sYAkhAT+Mkoc3KcCkdjEKNH65wozSIJNwFli/uQ3
        YLaIgK3Ey67pbF2MHBzMAnNYJNpLQMLCQENX/3vOAlFiKrFk3R9WCNtI4su6M2A2i4CqxN3j
        XUwgNq+AnUTf5Y/MEHvtJF7MPAhWwylgL/F6+wGwOYwCshLTHt0Hq2cWEJe49WQ+E8QDAhJL
        9pxnhrBFJV4+/scKco6EgJJE3waoch2JBbs/sUHY2hLLFr5mhlgrKHFy5hOWCYxis5BMnYWk
        ZRaSlllIWhYwsqxilE7OK87IKs7NzDMw1cvLz85M1C1OSs3J0UvOz93ECIzeNRKT5u5g7OyM
        P8QowMGoxMO7YoJXnBBrYllxZe4hRgkOZiURXm9xoBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe
        lskLY4UE0hNLUrNTUwtSi2CyTBycUg2MJffONirMvJK+7cmplfeuNZRbBj+4/HD+btX709+W
        /90w67wyv1ZIwoTlXPzsl1dbrF/57dPn/Nb+KNXoKZteZQVEifAvjIpNDm+Wu8ifVeKhPfdM
        w/neD4KGj0RkI9eyhf/f4PF5auv77XdLpW78F/nTbRK5e80mdeWEeyyLvTknlJufKn/bqMRS
        nJFoqMVcVJwIAC7QFWnaAgAA
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

Hi, 

I found the SCTP Stream negotiation doesn't work as expected, that is, the local outbound stream and the remote inbound stream comparison seems missing.
For example, when the local outstream(16) is greater than the remote inbound stream(2), 16 is saved and used as the "OUTS", which is shown from /proc/pid/net/sctp/assocs below.
Can anyone help comment?

From local end point, 16 is set as both the outbound and inbound stream.
From the remote end point, 2 is set for both the outbound and inbound stream

However, after the association is up, the inbound and outbound stream is set as (2,16), which I think is unexpected.
sh-4.2# cat 1/net/sctp/assocs
ASSOC SOCK STY SST ST HBKT ASSOC-ID TX_QUEUE RX_QUEUE UID INODE LPORT RPORT LADDRS <-> RADDRS HBINT INS OUTS MAXRT T1X T2X RTXC wmema wmemq sndbuf rcvbuf
55dae5bb bb3dec72 0 7 3 0 2415 0 0 504 1223451 2905 3904 xx.xx.xx.xx yy.yy.yy.yy <-> *zz.zz.zz.zz ww.ww.ww.ww 30000 2 16 10 0 0 0 1 0 262144 262144

I further checked the kernel code and found in v5.0, there is still comparison logic: min(outcnt, stream->outcnt) and save the smaller one in the function sctp_stream_alloc_out().
But the logic disappeared in v5.1, and if the "outcnt" is smaller, it's not saved locally.
static int sctp_stream_alloc_out(struct sctp_stream *stream, __u16 outcnt,
                                gfp_t gfp)
{
        int ret;

        if (outcnt <= stream->outcnt) //Here is problematic, and the outcnt is not saved locally.
                return 0;

        ret = genradix_prealloc(&stream->out, outcnt, gfp);
        if (ret)
                return ret;

        stream->outcnt = outcnt;
        return 0;
}

Thanks,
Jessie and Chris
