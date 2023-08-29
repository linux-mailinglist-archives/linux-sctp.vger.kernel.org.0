Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF27C78CD8B
	for <lists+linux-sctp@lfdr.de>; Tue, 29 Aug 2023 22:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239317AbjH2U2h (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Tue, 29 Aug 2023 16:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232406AbjH2U2M (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Tue, 29 Aug 2023 16:28:12 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC56FC;
        Tue, 29 Aug 2023 13:28:09 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d7830c5b20aso268363276.0;
        Tue, 29 Aug 2023 13:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693340889; x=1693945689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPW+cOvYjdKPx86Qz2gFq/jADvb6OQZRgDTzS7TqGTE=;
        b=GRcM7Pgi7fDBwz6pP22iDKve7e14XPbj9rquPI22umZzjsWcsiTA+CW0eLlBTjonnb
         VXMJ/0hbprZJBEmP4azLMPYN+1DhTjwx9tnZZSRCSVTklLkAVJ815AK6k5OewLCKgmC1
         jynpcvadXdLkFRoUhYPMl9ewwoxjiFVmJKO4EYSOLXCEXt3EsJFpABdNY5w1FNh0TbWo
         bIkhsZUKAX6nfh63fJn5gCBo83CmJaEtXdDscwLEaX6xC8V1zrWij8g5bpxD8zqLc+vz
         golGeUWXw6dZ/95D3hksX1JfHkU4kM1X5Uj1BSXFGG69PfEEEBJIHqucZLct8eKmy401
         /P1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693340889; x=1693945689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPW+cOvYjdKPx86Qz2gFq/jADvb6OQZRgDTzS7TqGTE=;
        b=FtA0n8hQpyFfNQ7YHgqVqPq6RLHfe+weSvVreZWnxEW6iewsH5QkJ2eUpPoWxNhRjJ
         shzUix5FbwTPcTbbh8a4P8ogWrC7iRmt/2rCymGd+hf9UE/ph+gZNWTm/yBYzSCADH9k
         p6DuWi4vPZg6OkV039Tkrh5g3qdych6pDsvmxeRDfy5LBvLyhju9BosXD85MxGe2GDN8
         NOHVtCk/mCGZubrxGtwfMi9exo2S9twPfuwqx2Y4vQcMWhpMUngKo+pYHWIj4oWL4nc1
         ZWRVCG8jKrp+GhYtW26BfXP7C43tWOE7vyIuHPdQ1dRYJz7F9dRhjeghHwyvgzEtfRy4
         A5AQ==
X-Gm-Message-State: AOJu0YxfJEgPhfUszFO1ZJWtq2AqhiPJ20TvkRN9v3GVtR2VDk41RpML
        +HHb/ZOCHzZYpERYx8vCPLd3HE4CfOP/lrgI++U=
X-Google-Smtp-Source: AGHT+IFN9KsI/KIYW36rLN6ro7UvPWLJe/AkYqpEHQtIP3KTxPCc24Pk5crT24CtYNL6vyVfaJdFxgjNXA+jrFJ0AIQ=
X-Received: by 2002:a25:b003:0:b0:d72:652f:4054 with SMTP id
 q3-20020a25b003000000b00d72652f4054mr3781771ybf.16.1693340888850; Tue, 29 Aug
 2023 13:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230829071334.58083-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20230829071334.58083-1-n.zhandarovich@fintech.ru>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Tue, 29 Aug 2023 16:27:48 -0400
Message-ID: <CADvbK_eQaqSJmNDGwz5A9tAmb0y2rZwZXxdC52B4hjjWRGZtUA@mail.gmail.com>
Subject: Re: [PATCH net] sctp: fix uninit-value in sctp_inq_pop()
To:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc:     Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+70a42f45e76bede082be@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Tue, Aug 29, 2023 at 3:14=E2=80=AFAM Nikita Zhandarovich
<n.zhandarovich@fintech.ru> wrote:
>
> Syzbot identified a case [1] of uninitialized memory usage in
> sctp_inq_pop(), specifically in 'ch->length'.
>
> Fix the issue by ensuring that 'ch->length' reflects the size of
> 'sctp_chunkhdr *ch' before accessing it.
>
> [1]
> BUG: KMSAN: uninit-value in sctp_inq_pop+0x1597/0x1910 net/sctp/inqueue.c=
:205
>  sctp_inq_pop+0x1597/0x1910 net/sctp/inqueue.c:205
>  sctp_assoc_bh_rcv+0x1a7/0xc50 net/sctp/associola.c:997
>  sctp_inq_push+0x23e/0x2b0 net/sctp/inqueue.c:80
>  sctp_backlog_rcv+0x394/0xd80 net/sctp/input.c:331
>  sk_backlog_rcv include/net/sock.h:1115 [inline]
>  __release_sock+0x207/0x570 net/core/sock.c:2911
>  release_sock+0x6b/0x1e0 net/core/sock.c:3478
>  sctp_wait_for_connect+0x486/0x810 net/sctp/socket.c:9325
>  sctp_sendmsg_to_asoc+0x1ea7/0x1ee0 net/sctp/socket.c:1884
>  ...
>
> Uninit was stored to memory at:
>  sctp_inq_pop+0x151a/0x1910 net/sctp/inqueue.c:201
>  sctp_assoc_bh_rcv+0x1a7/0xc50 net/sctp/associola.c:997
>  sctp_inq_push+0x23e/0x2b0 net/sctp/inqueue.c:80
>  sctp_backlog_rcv+0x394/0xd80 net/sctp/input.c:331
>  sk_backlog_rcv include/net/sock.h:1115 [inline]
>  __release_sock+0x207/0x570 net/core/sock.c:2911
>  release_sock+0x6b/0x1e0 net/core/sock.c:3478
>  sctp_wait_for_connect+0x486/0x810 net/sctp/socket.c:9325
>  sctp_sendmsg_to_asoc+0x1ea7/0x1ee0 net/sctp/socket.c:1884
>  ...
>
> Uninit was created at:
>  slab_post_alloc_hook+0x12d/0xb60 mm/slab.h:716
>  slab_alloc_node mm/slub.c:3451 [inline]
>  __kmem_cache_alloc_node+0x4ff/0x8b0 mm/slub.c:3490
>  __do_kmalloc_node mm/slab_common.c:965 [inline]
>  __kmalloc_node_track_caller+0x118/0x3c0 mm/slab_common.c:986
>  kmalloc_reserve+0x248/0x470 net/core/skbuff.c:585
>  __alloc_skb+0x318/0x740 net/core/skbuff.c:654
>  alloc_skb include/linux/skbuff.h:1288 [inline]
>  sctp_packet_pack net/sctp/output.c:472 [inline]
>  sctp_packet_transmit+0x1729/0x4150 net/sctp/output.c:621
>  sctp_outq_flush_transports net/sctp/outqueue.c:1173 [inline]
>  ...
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-and-tested-by: syzbot+70a42f45e76bede082be@syzkaller.appspotmail=
.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D70a42f45e76bede082be
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
>  net/sctp/inqueue.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
> index 7182c5a450fb..98ce9524c87c 100644
> --- a/net/sctp/inqueue.c
> +++ b/net/sctp/inqueue.c
> @@ -197,6 +197,7 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queu=
e)
>                 }
>         }
>
> +       ch->length =3D htons(sizeof(*ch));
>         chunk->chunk_hdr =3D ch;
>         chunk->chunk_end =3D ((__u8 *)ch) + SCTP_PAD4(ntohs(ch->length));
>         skb_pull(chunk->skb, sizeof(*ch));
> --
> 2.25.1
>
Hi, Nikita

You can't just overwrite "ch->length", "ch" is the header of the received c=
hunk.
if it says ch->length is Uninit, it means either the chunk parsing in
the receiver
is overflow or the format of the chunk created in the sender is incorrect.

If you can reproduce it stably, I suggest you start from sctp_inq_pop() and
print out the skb info and data in there, and see if it's a normal chunk.

Thanks.
