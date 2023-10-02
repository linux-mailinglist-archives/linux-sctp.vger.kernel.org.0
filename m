Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348A27B55CC
	for <lists+linux-sctp@lfdr.de>; Mon,  2 Oct 2023 17:01:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237913AbjJBO7w (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Mon, 2 Oct 2023 10:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237920AbjJBO7v (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Mon, 2 Oct 2023 10:59:51 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E998BB7;
        Mon,  2 Oct 2023 07:59:47 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-d8cc08fb47dso2423898276.3;
        Mon, 02 Oct 2023 07:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696258787; x=1696863587; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q53XKUuDDMvCFBaS7mJ2d26tUdSLzM6Jemr2bfcRJx0=;
        b=XOy/JGc3rG48KrIrb4aUyOQ2+csIdD5bWxu8bjDagsvqkWWX28syERCiYZ05dbiYwd
         QXSsa+Ya0/BlaLSyI0bUyJDTzSHxp7yDuhtEs6s97j5/l4VhV3lSaPmE7tnmgHu4QzXY
         Zq90FyNkD8xlEk5CaMb6B6ulyee0RxL6pY1DLsLEN/BmkBk4VHmmNzev/vftYLMh6D9I
         8spTcZMg+4yPo5q4BuPuTKpTiOEIS65Hu5GJrh/+QHjVLlp+TLjY9zOn7zw6JQNjjBSQ
         DQ3uRJPteClHSGh5wahVI7dy7phxebfr7TfA1UnSoSdnhTQ/JKwDHzz2DE0bKdphCzK1
         JGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696258787; x=1696863587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q53XKUuDDMvCFBaS7mJ2d26tUdSLzM6Jemr2bfcRJx0=;
        b=FeyS1VW4IbD4Qc+PyHbKSWY7yHZTQne+3FO/4wd2zdTMuIGFQZxgg7EM9i9Yr7TIvS
         5bTef1JPxDWVgX/KCVqJn3VfHXK88aZ/BwjvwPq9EgXZVtlUSJdd8k0n6R+YzApI5Vh0
         +WYRtpx7g2lZAXNcOKGtqAGzL8wqoa+upB06Dp7xY+70+jU/eFpnm3tzxrW4sff5oVAj
         nmMZWd4syNgumNrc05m+X9HqFWOpJlFYvOKIf///PmjYZ9pkd+mH5Y2HDE+KT/pCv7QL
         uM+D5kcrC+NtnnMQweqamhGUEN+RA9hoin1pEOVPvdmLTdWEqfyiqip5JUL+/iim/c7E
         MKaA==
X-Gm-Message-State: AOJu0YxbBUFdiQ3e3KCxui5B867ycacCO708hfJivthyrX5fht9A1+an
        +XFbR/dRauoer2uBYdxZzexPkVHRSZri8JRtEWTJW76EPgIRYg==
X-Google-Smtp-Source: AGHT+IHgGs7/VN5rANVTx4wQVdDj+I8GbJVZ7NZsc9nJ6a3N87XY0RNVK8qznqZ8rWRlgQ9XNXH5fhANVOzadm2yD9k=
X-Received: by 2002:a25:1983:0:b0:d81:6691:9f8d with SMTP id
 125-20020a251983000000b00d8166919f8dmr10078553ybz.19.1696258786831; Mon, 02
 Oct 2023 07:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <6ee630f777cada3259b29e732e7ea9321a99197b.1696172868.git.lucien.xin@gmail.com>
In-Reply-To: <6ee630f777cada3259b29e732e7ea9321a99197b.1696172868.git.lucien.xin@gmail.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Mon, 2 Oct 2023 10:59:35 -0400
Message-ID: <CADvbK_fE2KGLtqBxFUVikrCxkRjG_eodeHjRuMGWU=og_qk9_A@mail.gmail.com>
Subject: Re: [PATCH nf] netfilter: handle the connecting collision properly in nf_conntrack_proto_sctp
To:     network dev <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, linux-sctp@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000006fd14d0606bd064f"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

--0000000000006fd14d0606bd064f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 1, 2023 at 11:07=E2=80=AFAM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> In Scenario A and B below, as the delayed INIT_ACK always changes the pee=
r
> vtag, SCTP ct with the incorrect vtag may cause packet loss.
>
> Scenario A: INIT_ACK is delayed until the peer receives its own INIT_ACK
>
>   192.168.1.2 > 192.168.1.1: [INIT] [init tag: 1328086772]
>     192.168.1.1 > 192.168.1.2: [INIT] [init tag: 1414468151]
>     192.168.1.2 > 192.168.1.1: [INIT ACK] [init tag: 1328086772]
>   192.168.1.1 > 192.168.1.2: [INIT ACK] [init tag: 1650211246] *
>   192.168.1.2 > 192.168.1.1: [COOKIE ECHO]
>     192.168.1.1 > 192.168.1.2: [COOKIE ECHO]
>     192.168.1.2 > 192.168.1.1: [COOKIE ACK]
>
> Scenario B: INIT_ACK is delayed until the peer completes its own handshak=
e
>
>   192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
>     192.168.1.1 > 192.168.1.2: sctp (1) [INIT] [init tag: 144230885]
>     192.168.1.2 > 192.168.1.1: sctp (1) [INIT ACK] [init tag: 3922216408]
>     192.168.1.1 > 192.168.1.2: sctp (1) [COOKIE ECHO]
>     192.168.1.2 > 192.168.1.1: sctp (1) [COOKIE ACK]
>   192.168.1.1 > 192.168.1.2: sctp (1) [INIT ACK] [init tag: 3914796021] *
>
> This patch fixes it as below:
>
> In SCTP_CID_INIT processing:
> - clear ct->proto.sctp.init[!dir] if ct->proto.sctp.init[dir] &&
>   ct->proto.sctp.init[!dir]. (Scenario E)
> - set ct->proto.sctp.init[dir].
>
> In SCTP_CID_INIT_ACK processing:
> - drop it if !ct->proto.sctp.init[!dir] && ct->proto.sctp.vtag[!dir] &&
>   ct->proto.sctp.vtag[!dir] !=3D ih->init_tag. (Scenario B, Scenario C)
> - drop it if ct->proto.sctp.init[dir] && ct->proto.sctp.init[!dir] &&
>   ct->proto.sctp.vtag[!dir] !=3D ih->init_tag. (Scenario A)
>
> In SCTP_CID_COOKIE_ACK processing:
> - clear ct->proto.sctp.init[dir] and ct->proto.sctp.init[!dir]. (Scenario=
 D)
>
> Also, it's important to allow the ct state to move forward with cookie_ec=
ho
> and cookie_ack from the opposite dir for the collision scenarios.
>
> There are also other Scenarios where it should allow the packet through,
> addressed by the processing above:
>
> Scenario C: new CT is created by INIT_ACK.
>
> Scenario D: start INIT on the existing ESTABLISHED ct.
>
> Scenario E: start INIT after the old collision on the existing ESTABLISHE=
D ct.
>
>   192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
>   192.168.1.1 > 192.168.1.2: sctp (1) [INIT] [init tag: 144230885]
>   (both side are stopped, then start new connection again in hours)
>   192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 242308742]
>
> Signed-off-by: Xin Long <lucien.xin@gmail.com>
> ---
>  include/linux/netfilter/nf_conntrack_sctp.h |  1 +
>  net/netfilter/nf_conntrack_proto_sctp.c     | 41 ++++++++++++++++-----
>  2 files changed, 33 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/netfilter/nf_conntrack_sctp.h b/include/linux/=
netfilter/nf_conntrack_sctp.h
> index 625f491b95de..fb31312825ae 100644
> --- a/include/linux/netfilter/nf_conntrack_sctp.h
> +++ b/include/linux/netfilter/nf_conntrack_sctp.h
> @@ -9,6 +9,7 @@ struct ip_ct_sctp {
>         enum sctp_conntrack state;
>
>         __be32 vtag[IP_CT_DIR_MAX];
> +       u8 init[IP_CT_DIR_MAX];
>         u8 last_dir;
>         u8 flags;
>  };
> diff --git a/net/netfilter/nf_conntrack_proto_sctp.c b/net/netfilter/nf_c=
onntrack_proto_sctp.c
> index b6bcc8f2f46b..91aee286d503 100644
> --- a/net/netfilter/nf_conntrack_proto_sctp.c
> +++ b/net/netfilter/nf_conntrack_proto_sctp.c
> @@ -112,7 +112,7 @@ static const u8 sctp_conntracks[2][11][SCTP_CONNTRACK=
_MAX] =3D {
>  /* shutdown_ack */ {sSA, sCL, sCW, sCE, sES, sSA, sSA, sSA, sSA},
>  /* error        */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCL},/* Can'=
t have Stale cookie*/
>  /* cookie_echo  */ {sCL, sCL, sCE, sCE, sES, sSS, sSR, sSA, sCL},/* 5.2.=
4 - Big TODO */
> -/* cookie_ack   */ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sCL},/* Can'=
t come in orig dir */
> +/* cookie_ack   */ {sCL, sCL, sCW, sES, sES, sSS, sSR, sSA, sCL},/* Can'=
t come in orig dir */
>  /* shutdown_comp*/ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sCL, sCL},
>  /* heartbeat    */ {sHS, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS},
>  /* heartbeat_ack*/ {sCL, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS},
> @@ -126,7 +126,7 @@ static const u8 sctp_conntracks[2][11][SCTP_CONNTRACK=
_MAX] =3D {
>  /* shutdown     */ {sIV, sCL, sCW, sCE, sSR, sSS, sSR, sSA, sIV},
>  /* shutdown_ack */ {sIV, sCL, sCW, sCE, sES, sSA, sSA, sSA, sIV},
>  /* error        */ {sIV, sCL, sCW, sCL, sES, sSS, sSR, sSA, sIV},
> -/* cookie_echo  */ {sIV, sCL, sCW, sCE, sES, sSS, sSR, sSA, sIV},/* Can'=
t come in reply dir */
> +/* cookie_echo  */ {sIV, sCL, sCE, sCE, sES, sSS, sSR, sSA, sIV},/* Can'=
t come in reply dir */
>  /* cookie_ack   */ {sIV, sCL, sCW, sES, sES, sSS, sSR, sSA, sIV},
>  /* shutdown_comp*/ {sIV, sCL, sCW, sCE, sES, sSS, sSR, sCL, sIV},
>  /* heartbeat    */ {sIV, sCL, sCW, sCE, sES, sSS, sSR, sSA, sHS},
> @@ -412,6 +412,9 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
>                         /* (D) vtag must be same as init_vtag as found in=
 INIT_ACK */
>                         if (sh->vtag !=3D ct->proto.sctp.vtag[dir])
>                                 goto out_unlock;
> +               } else if (sch->type =3D=3D SCTP_CID_COOKIE_ACK) {
> +                       ct->proto.sctp.init[dir] =3D 0;
> +                       ct->proto.sctp.init[!dir] =3D 0;
>                 } else if (sch->type =3D=3D SCTP_CID_HEARTBEAT) {
>                         if (ct->proto.sctp.vtag[dir] =3D=3D 0) {
>                                 pr_debug("Setting %d vtag %x for dir %d\n=
", sch->type, sh->vtag, dir);
> @@ -461,16 +464,18 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
>                 }
>
>                 /* If it is an INIT or an INIT ACK note down the vtag */
> -               if (sch->type =3D=3D SCTP_CID_INIT ||
> -                   sch->type =3D=3D SCTP_CID_INIT_ACK) {
> -                       struct sctp_inithdr _inithdr, *ih;
> +               if (sch->type =3D=3D SCTP_CID_INIT) {
> +                       struct sctp_inithdr _ih, *ih;
>
> -                       ih =3D skb_header_pointer(skb, offset + sizeof(_s=
ch),
> -                                               sizeof(_inithdr), &_inith=
dr);
> +                       ih =3D skb_header_pointer(skb, offset + sizeof(_s=
ch), sizeof(*ih), &_ih);
>                         if (ih =3D=3D NULL)
>                                 goto out_unlock;
> -                       pr_debug("Setting vtag %x for dir %d\n",
> -                                ih->init_tag, !dir);
> +
> +                       if (ct->proto.sctp.init[dir] && ct->proto.sctp.in=
it[!dir])
> +                               ct->proto.sctp.init[!dir] =3D 0;
> +                       ct->proto.sctp.init[dir] =3D 1;
> +
> +                       pr_debug("Setting vtag %x for dir %d\n", ih->init=
_tag, !dir);
>                         ct->proto.sctp.vtag[!dir] =3D ih->init_tag;
>
>                         /* don't renew timeout on init retransmit so
> @@ -481,6 +486,24 @@ int nf_conntrack_sctp_packet(struct nf_conn *ct,
>                             old_state =3D=3D SCTP_CONNTRACK_CLOSED &&
>                             nf_ct_is_confirmed(ct))
>                                 ignore =3D true;
> +               } else if (sch->type =3D=3D SCTP_CID_INIT_ACK) {
> +                       struct sctp_inithdr _ih, *ih;
> +                       u32 vtag;
> +
> +                       ih =3D skb_header_pointer(skb, offset + sizeof(_s=
ch), sizeof(*ih), &_ih);
> +                       if (ih =3D=3D NULL)
> +                               goto out_unlock;
> +
> +                       vtag =3D ct->proto.sctp.vtag[!dir];
> +                       if (!ct->proto.sctp.init[!dir] && vtag && vtag !=
=3D ih->init_tag)
> +                               goto out_unlock;
> +                       /* collision */
> +                       if (ct->proto.sctp.init[dir] && ct->proto.sctp.in=
it[!dir] &&
> +                           vtag !=3D ih->init_tag)
> +                               goto out_unlock;
> +
> +                       pr_debug("Setting vtag %x for dir %d\n", ih->init=
_tag, !dir);
> +                       ct->proto.sctp.vtag[!dir] =3D ih->init_tag;
>                 }
>
>                 ct->proto.sctp.state =3D new_state;
> --
> 2.39.1
>
a reproducer is attached.

Thanks.

--0000000000006fd14d0606bd064f
Content-Type: text/x-sh; charset="US-ASCII"; name="sctp_collision.sh"
Content-Disposition: attachment; filename="sctp_collision.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_ln90nps30>
X-Attachment-Id: f_ln90nps30

IyEvYmluL2Jhc2gKIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAojCiMgVGVzdGlu
ZyBGb3IgU0NUUCBDT0xMSVNJT04gU0NFTkFSSU8gYXMgQmVsb3c6CiMKIyAgIDE0OjM1OjQ3LjY1
NTI3OSBJUCAxOTguNTEuMjAwLjEuMTIzNCA+IDE5OC41MS4xMDAuMS4xMjM0OiBzY3RwICgxKSBb
SU5JVF0gW2luaXQgdGFnOiAyMDE3ODM3MzU5XQojICAgMTQ6MzU6NDguMzUzMjUwIElQIDE5OC41
MS4xMDAuMS4xMjM0ID4gMTk4LjUxLjIwMC4xLjEyMzQ6IHNjdHAgKDEpIFtJTklUXSBbaW5pdCB0
YWc6IDExODcyMDYxODddCiMgICAxNDozNTo0OC4zNTMyNzUgSVAgMTk4LjUxLjIwMC4xLjEyMzQg
PiAxOTguNTEuMTAwLjEuMTIzNDogc2N0cCAoMSkgW0lOSVQgQUNLXSBbaW5pdCB0YWc6IDIwMTc4
MzczNTldCiMgICAxNDozNTo0OC4zNTMyODMgSVAgMTk4LjUxLjEwMC4xLjEyMzQgPiAxOTguNTEu
MjAwLjEuMTIzNDogc2N0cCAoMSkgW0NPT0tJRSBFQ0hPXQojICAgMTQ6MzU6NDguMzUzOTc3IElQ
IDE5OC41MS4yMDAuMS4xMjM0ID4gMTk4LjUxLjEwMC4xLjEyMzQ6IHNjdHAgKDEpIFtDT09LSUUg
QUNLXQojICAgMTQ6MzU6NDguODU1MzM1IElQIDE5OC41MS4xMDAuMS4xMjM0ID4gMTk4LjUxLjIw
MC4xLjEyMzQ6IHNjdHAgKDEpIFtJTklUIEFDS10gW2luaXQgdGFnOiAxNjQ1Nzk5NzBdCiMKIyBU
T1BPOiBvYW1jbSAobGluazApPC0tLT4obGluazEpIEhPU1QvUk9VVEVSIChsaW5rMik8LS0tPihs
aW5rMykgb2FtYmIKCiMgaW5jbHVkZSB0aGUgYyB0ZXN0IGZpbGUgaW4gdGhpcyBzY3JpcHQKY2F0
ID4gLi9zY3RwX3Rlc3QuYyA8PCBFT0YKI2luY2x1ZGUgPHN0ZGlvLmg+CiNpbmNsdWRlIDxzdGRs
aWIuaD4KI2luY2x1ZGUgPHN0cmluZy5oPgojaW5jbHVkZSA8dW5pc3RkLmg+CiNpbmNsdWRlIDxh
cnBhL2luZXQuaD4KCmludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCnsKCXN0cnVjdCBz
b2NrYWRkcl9pbiBzYWRkciA9IHt9LCBkYWRkciA9IHt9OwoJaW50IHNkLCByZXQsIGxlbiA9IHNp
emVvZihkYWRkcik7CglzdHJ1Y3QgdGltZXZhbCB0diA9IHsyNSwgMH07CgljaGFyIGJ1ZltdID0g
ImhlbGxvIjsKCglpZiAoYXJnYyAhPSA2IHx8IChzdHJjbXAoYXJndlsxXSwgInNlcnZlciIpICYm
IHN0cmNtcChhcmd2WzFdLCAiY2xpZW50IikpKSB7CgkJcHJpbnRmKCIlcyA8c2VydmVyfGNsaWVu
dD4gPExPQ0FMX0lQPiA8TE9DQUxfUE9SVD4gPFJFTU9URV9JUD4gPFJFTU9URV9QT1JUPlxuIiwg
YXJndlswXSk7CgkJcmV0dXJuIC0xOwoJfQoKCXNkID0gc29ja2V0KEFGX0lORVQsIFNPQ0tfU0VR
UEFDS0VULCBJUFBST1RPX1NDVFApOwoJaWYgKHNkIDwgMCkgewoJCXByaW50ZigiRmFpbGVkIHRv
IGNyZWF0ZSBzZFxuIik7CgkJcmV0dXJuIC0xOwoJfQoKCXNhZGRyLnNpbl9mYW1pbHkgPSBBRl9J
TkVUOwoJc2FkZHIuc2luX2FkZHIuc19hZGRyID0gaW5ldF9hZGRyKGFyZ3ZbMl0pOwoJc2FkZHIu
c2luX3BvcnQgPSBodG9ucyhhdG9pKGFyZ3ZbM10pKTsKCglyZXQgPSBiaW5kKHNkLCAoc3RydWN0
IHNvY2thZGRyICopJnNhZGRyLCBzaXplb2Yoc2FkZHIpKTsKCWlmIChyZXQgPCAwKSB7CgkJcHJp
bnRmKCJGYWlsZWQgdG8gYmluZCB0byBhZGRyZXNzXG4iKTsKCQlyZXR1cm4gLTE7Cgl9CgoJcmV0
ID0gbGlzdGVuKHNkLCA1KTsKCWlmIChyZXQgPCAwKSB7CgkJcHJpbnRmKCJGYWlsZWQgdG8gbGlz
dGVuIG9uIHBvcnRcbiIpOwoJCXJldHVybiAtMTsKCX0KCglkYWRkci5zaW5fZmFtaWx5ID0gQUZf
SU5FVDsKCWRhZGRyLnNpbl9hZGRyLnNfYWRkciA9IGluZXRfYWRkcihhcmd2WzRdKTsKCWRhZGRy
LnNpbl9wb3J0ID0gaHRvbnMoYXRvaShhcmd2WzVdKSk7CgoJLyogbWFrZSB0ZXN0IHNob3J0ZXIg
dGhhbiAyNXMgKi8KCXJldCA9IHNldHNvY2tvcHQoc2QsIFNPTF9TT0NLRVQsIFNPX1JDVlRJTUVP
LCAmdHYsIHNpemVvZih0dikpOwoJaWYgKHJldCA8IDApIHsKCQlwcmludGYoIkZhaWxlZCB0byBz
ZXRzb2Nrb3B0IFNPX1JDVlRJTUVPXG4iKTsKCQlyZXR1cm4gLTE7Cgl9CgoJaWYgKCFzdHJjbXAo
YXJndlsxXSwgInNlcnZlciIpKSB7CgkJc2xlZXAoMSk7IC8qIHdhaXQgYSBiaXQgZm9yIGNsaWVu
dCdzIElOSVQgKi8KCQlyZXQgPSBjb25uZWN0KHNkLCAoc3RydWN0IHNvY2thZGRyICopJmRhZGRy
LCBsZW4pOwoJCWlmIChyZXQgPCAwKSB7CgkJCXByaW50ZigiRmFpbGVkIHRvIGNvbm5lY3QgdG8g
cGVlclxuIik7CgkJCXJldHVybiAtMTsKCQl9CgkJcmV0ID0gcmVjdmZyb20oc2QsIGJ1Ziwgc2l6
ZW9mKGJ1ZiksIDAsIChzdHJ1Y3Qgc29ja2FkZHIgKikmZGFkZHIsICZsZW4pOwoJCWlmIChyZXQg
PCAwKSB7CgkJCXByaW50ZigiRmFpbGVkIHRvIHJlY3YgbXNnICVkXG4iLCByZXQpOwoJCQlyZXR1
cm4gLTE7CgkJfQoJCXJldCA9IHNlbmR0byhzZCwgYnVmLCBzdHJsZW4oYnVmKSArIDEsIDAsIChz
dHJ1Y3Qgc29ja2FkZHIgKikmZGFkZHIsIGxlbik7CgkJaWYgKHJldCA8IDApIHsKCQkJcHJpbnRm
KCJGYWlsZWQgdG8gc2VuZCBtc2cgJWRcbiIsIHJldCk7CgkJCXJldHVybiAtMTsKCQl9CgkJcHJp
bnRmKCJTZXJ2ZXI6IHNlbnQhICVkXG4iLCByZXQpOwoJfQoKCWlmICghc3RyY21wKGFyZ3ZbMV0s
ICJjbGllbnQiKSkgewoJCXVzbGVlcCgzMDAwMDApOyAvKiB3YWl0IGEgYml0IGZvciBzZXJ2ZXIn
cyBsaXN0ZW5pbmcgKi8KCQlyZXQgPSBjb25uZWN0KHNkLCAoc3RydWN0IHNvY2thZGRyICopJmRh
ZGRyLCBsZW4pOwoJCWlmIChyZXQgPCAwKSB7CgkJCXByaW50ZigiRmFpbGVkIHRvIGNvbm5lY3Qg
dG8gcGVlclxuIik7CgkJCXJldHVybiAtMTsKCQl9CgkJc2xlZXAoMSk7IC8qIHdhaXQgYSBiaXQg
Zm9yIHNlcnZlcidzIGRlbGF5ZWQgSU5JVF9BQ0sgdG8gcmVwcm9kdWNlIHRoZSBpc3N1ZSAqLwoJ
CXJldCA9IHNlbmR0byhzZCwgYnVmLCBzdHJsZW4oYnVmKSArIDEsIDAsIChzdHJ1Y3Qgc29ja2Fk
ZHIgKikmZGFkZHIsIGxlbik7CgkJaWYgKHJldCA8IDApIHsKCQkJcHJpbnRmKCJGYWlsZWQgdG8g
c2VuZCBtc2cgJWRcbiIsIHJldCk7CgkJCXJldHVybiAtMTsKCQl9CgkJcmV0ID0gcmVjdmZyb20o
c2QsIGJ1Ziwgc2l6ZW9mKGJ1ZiksIDAsIChzdHJ1Y3Qgc29ja2FkZHIgKikmZGFkZHIsICZsZW4p
OwoJCWlmIChyZXQgPCAwKSB7CgkJCXByaW50ZigiRmFpbGVkIHRvIHJlY3YgbXNnICVkXG4iLCBy
ZXQpOwoJCQlyZXR1cm4gLTE7CgkJfQoJCXByaW50ZigiQ2xpZW50OiByY3ZkISAlZFxuIiwgcmV0
KTsKCX0KCgljbG9zZShzZCk7CglyZXR1cm4gMDsKfQpFT0YKCmlmICEgY29ubnRyYWNrIC1WOyB0
aGVuCgllY2hvICJTS0lQOiBDb3VsZCBub3QgcnVuIHRlc3Qgd2l0aG91dCBjb25udHJhY2stdG9v
bHMsIHRyeSAjIGRuZiBpbnN0YWxsIC15IGNvbm50cmFjay10b29scyIKCWV4aXQgNApmaQppZiAh
IG1ha2Ugc2N0cF90ZXN0OyB0aGVuCgllY2hvICJTS0lQOiBGYWlsZWQgdG8gY29tcGlsZSBzY3Rw
X3Rlc3QuYyIKCWV4aXQgNApmaQoKIyBjbGVhbiB1cAppcCBuZXRucyBkZWwgb2FtY20gPiAvZGV2
L251bGwgMj4mMQppcCBuZXRucyBkZWwgb2FtYmIgPiAvZGV2L251bGwgMj4mMQppcCBsaW5rIGRl
bCBsaW5rMSA+IC9kZXYvbnVsbCAyPiYxCmlwIGxpbmsgZGVsIGxpbmsyID4gL2Rldi9udWxsIDI+
JjEKY29ubnRyYWNrIC1EIC1wIHNjdHAgPiAvZGV2L251bGwgMj4mMQppcHRhYmxlcyAtRgoKIyBz
ZXR1cCB0aGUgdG9wbwppcCBuZXRucyBhZGQgb2FtY20KaXAgbmV0bnMgYWRkIG9hbWJiCmlwIGxp
bmsgYWRkIGxpbmsxIHR5cGUgdmV0aCBwZWVyIG5hbWUgbGluazAgbmV0bnMgb2FtY20KaXAgbGlu
ayBhZGQgbGluazIgdHlwZSB2ZXRoIHBlZXIgbmFtZSBsaW5rMyBuZXRucyBvYW1iYgoKaXAgLW4g
b2FtY20gbGluayBzZXQgbGluazAgdXAKaXAgLW4gb2FtY20gYWRkciBhZGQgMTk4LjUxLjEwMC4x
LzI0IGRldiBsaW5rMAppcCAtbiBvYW1jbSByb3V0ZSBhZGQgMTk4LjUxLjIwMC4xIGRldiBsaW5r
MCB2aWEgMTk4LjUxLjEwMC4yCgppcCBsaW5rIHNldCBsaW5rMSB1cAppcCBsaW5rIHNldCBsaW5r
MiB1cAppcCBhZGRyIGFkZCAxOTguNTEuMTAwLjIvMjQgZGV2IGxpbmsxCmlwIGFkZHIgYWRkIDE5
OC41MS4yMDAuMi8yNCBkZXYgbGluazIKc3lzY3RsIC13cSBuZXQuaXB2NC5pcF9mb3J3YXJkPTEK
CmlwIC1uIG9hbWJiIGxpbmsgc2V0IGxpbmszIHVwCmlwIC1uIG9hbWJiIGFkZHIgYWRkIDE5OC41
MS4yMDAuMS8yNCBkZXYgbGluazMKaXAgLW4gb2FtYmIgcm91dGUgYWRkIDE5OC41MS4xMDAuMSBk
ZXYgbGluazMgdmlhIDE5OC41MS4yMDAuMgoKIyBzaW11bGF0ZSB0aGUgZGVsYXkgb24gT1ZTIHVw
Y2FsbCBieSBzZXR0aW5nIHVwIGEgZGVsYXkgZm9yIElOSVRfQUNLIHdpdGggdGMgb24gb2FtY20g
c2lkZQp0YyAtbiBvYW1jbSBxZGlzYyBhZGQgZGV2IGxpbmswIHJvb3QgaGFuZGxlIDE6IGh0Ygp0
YyAtbiBvYW1jbSBjbGFzcyBhZGQgZGV2IGxpbmswIHBhcmVudCAxOiBjbGFzc2lkIDE6MSBodGIg
cmF0ZSAxMDBtYml0CnRjIC1uIG9hbWNtIGZpbHRlciBhZGQgZGV2IGxpbmswIHBhcmVudCAxOiBw
cm90b2NvbCBpcCB1MzIgbWF0Y2ggaXAgcHJvdG9jb2wgMTMyIDB4ZmYgbWF0Y2ggdTggMiAweGZm
IGF0IDMyIGZsb3dpZCAxOjEKdGMgLW4gb2FtY20gcWRpc2MgYWRkIGRldiBsaW5rMCBwYXJlbnQg
MToxIGhhbmRsZSAxMDogbmV0ZW0gZGVsYXkgMTIwMG1zCgojIHNpbXVsYXRlIHRoZSBjdHN0YXRl
IGNoZWNrIG9uIE9WUyBuZl9jb25udHJhY2sKaXB0YWJsZXMgLUEgRk9SV0FSRCAtbSBzdGF0ZSAt
LXN0YXRlIElOVkFMSUQsVU5UUkFDS0VEIC1qIERST1AKaXB0YWJsZXMgLUEgSU5QVVQgLXAgc2N0
cCAtaiBEUk9QCgojIHVzZSBhIHNtYWxsZXIgbnVtYmVyIGZvciBhc3NvYydzIG1heF9yZXRyYW5z
IHRvIHJlcHJvZHVjZSB0aGUgaXNzdWUKbW9kcHJvYmUgc2N0cAppcCBuZXRucyBleGVjIG9hbWJi
IHN5c2N0bCAtd3EgbmV0LnNjdHAuYXNzb2NpYXRpb25fbWF4X3JldHJhbnM9MwoKIyBOT1RFOiBv
bmUgd2F5IHRvIHdvcmsgYXJvdW5kIHRoZSBpc3N1ZSBpcyBzZXQgYSBzbWFsbGVyIGhiX2ludGVy
dmFsCiMgaXAgbmV0bnMgZXhlYyBvYW1iYiBzeXNjdGwgLXdxIG5ldC5zY3RwLmhiX2ludGVydmFs
PTM1MDAKCiMgcnVuIHRoZSB0ZXN0IGNhc2UKZWNobyAiVGVzdCBTdGFydGVkICh3YWl0IHVwIHRv
IDI1cyk6IgppcCBuZXQgZXhlYyBvYW1jbSAuL3NjdHBfdGVzdCBzZXJ2ZXIgMTk4LjUxLjEwMC4x
IDEyMzQgMTk4LjUxLjIwMC4xIDEyMzQgJgppcCBuZXQgZXhlYyBvYW1iYiAuL3NjdHBfdGVzdCBj
bGllbnQgMTk4LjUxLjIwMC4xIDEyMzQgMTk4LjUxLjEwMC4xIDEyMzQgJiYgZWNobyAiUEFTUyEi
ICYmIGV4aXQgMAplY2hvICJGQUlMISIgJiYgZXhpdCAxCg==
--0000000000006fd14d0606bd064f--
