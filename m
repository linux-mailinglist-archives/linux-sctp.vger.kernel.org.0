Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814DE2F47F9
	for <lists+linux-sctp@lfdr.de>; Wed, 13 Jan 2021 10:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbhAMJrk (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Wed, 13 Jan 2021 04:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbhAMJrj (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Wed, 13 Jan 2021 04:47:39 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEE7C061575;
        Wed, 13 Jan 2021 01:46:58 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id o17so1830052lfg.4;
        Wed, 13 Jan 2021 01:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nfUPr8y26do1BAejWzWu8alXAq5ZQjU/kAsBRfMRzOQ=;
        b=aPOlsM4h7HCOb0DIgiL/eZELG54EQNp0B5yK+loynUgCtKcH6MU3vZ/RvekdRmR2+I
         +fnrKBn5nHWLbx4EAZJL//PJB53KeZV5OF0zWLlRavoJ7JwmwK8cFMyQ6KgDOwZAb1gi
         fSPF3HlGANWkVuQb2YwZDdRqdrS1iafTTOpJ746O85swXuhyBkVUSeMa6fiQc5wuEtj7
         N5e1l3DLxJktWcaTmVcpjEXUZZBt4pJpkFUqWSE6qYdVru9ctWt/EqQjBsLcVst43tnJ
         ywzs0Yq6/GiLoMqh7mksNQCH6MBRgcapQBxMGOeALwiM0l47WngCq+GDxdaUHDZp09tM
         qzVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nfUPr8y26do1BAejWzWu8alXAq5ZQjU/kAsBRfMRzOQ=;
        b=Fzt978e0IYer2D0Vyn7vdW1t0R0iJz3EjTJFOZ05bp4iJfmwHNFMwOLZY9MM2xRPgo
         7H4dmru7Oi2ML6CNNClUh7YTiBWv2CREIPe6Ib6I16xJbXE0rcaUNiP919cmUxTfzV+m
         v9pk7lSr8N+K2nX8pVCMtRKY1kWfttz6x99nGBYc601yRLGjT2hwO5IpIfTtsPEyCTA0
         hnOzOK5sxhyNH6uWD5vsAjs0mBmTuEkFy19ZBYUPcyS7eKfj87MQOv0nH+IeVIY0c4Dx
         TngF2GBDkoZh4gdDCuOdyz3GA2xpYJxtL7iwOt3vFzsFpk+fmK0z0jcKixISL22CWU2t
         A4bA==
X-Gm-Message-State: AOAM530m/ekVri4Q2THMRPYOgtdvfkbl3lVxATnpw4hCsVaavghq/05f
        DGw/IC/czYHPCw3j/LA6LGeNugx/Exbg+gXzB7o=
X-Google-Smtp-Source: ABdhPJxK/UM0/KpxFkdQm/8nxxFYjHN+E70NfkOnEYJeaE7kDoh65vI2m8kwlKrkB7l1Bjmr9bVndY0sgfDYUiTBy/c=
X-Received: by 2002:a19:716:: with SMTP id 22mr549565lfh.390.1610531217048;
 Wed, 13 Jan 2021 01:46:57 -0800 (PST)
MIME-Version: 1.0
References: <d8dc3cd362915974426d8274bb8ac6970a2096bb.1610371323.git.lucien.xin@gmail.com>
 <CAKgT0UeEkqQjSU_t1wp3_k4pRYxM=FE-rTk2sBa-mdSwPnAstw@mail.gmail.com>
 <CADvbK_cr1bYUjUi-FrcDZwPX9nBkUqP3LZNx06b4sKrO3kdVdw@mail.gmail.com> <CAKgT0UfDQhD=J7RomDZmzjRsMSm6wgtaS-sc-grE00a=8kWN8Q@mail.gmail.com>
In-Reply-To: <CAKgT0UfDQhD=J7RomDZmzjRsMSm6wgtaS-sc-grE00a=8kWN8Q@mail.gmail.com>
From:   Xin Long <lucien.xin@gmail.com>
Date:   Wed, 13 Jan 2021 17:46:43 +0800
Message-ID: <CADvbK_fQove=-Oox8aLiZSdrpAFSiBNmtVBUs65v3O9rbzhE+A@mail.gmail.com>
Subject: Re: [PATCHv2 net-next] ip_gre: remove CRC flag from dev features in gre_gso_segment
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     network dev <netdev@vger.kernel.org>,
        "linux-sctp @ vger . kernel . org" <linux-sctp@vger.kernel.org>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Neil Horman <nhorman@tuxdriver.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Wed, Jan 13, 2021 at 10:11 AM Alexander Duyck
<alexander.duyck@gmail.com> wrote:
>
> On Mon, Jan 11, 2021 at 9:14 PM Xin Long <lucien.xin@gmail.com> wrote:
> >
> > On Tue, Jan 12, 2021 at 12:48 AM Alexander Duyck
> > <alexander.duyck@gmail.com> wrote:
> > >
> > > On Mon, Jan 11, 2021 at 5:22 AM Xin Long <lucien.xin@gmail.com> wrote:
> > > >
> > > > This patch is to let it always do CRC checksum in sctp_gso_segment()
> > > > by removing CRC flag from the dev features in gre_gso_segment() for
> > > > SCTP over GRE, just as it does in Commit 527beb8ef9c0 ("udp: support
> > > > sctp over udp in skb_udp_tunnel_segment") for SCTP over UDP.
> > > >
> > > > It could set csum/csum_start in GSO CB properly in sctp_gso_segment()
> > > > after that commit, so it would do checksum with gso_make_checksum()
> > > > in gre_gso_segment(), and Commit 622e32b7d4a6 ("net: gre: recompute
> > > > gre csum for sctp over gre tunnels") can be reverted now.
> > > >
> > > > Note that the current HWs like igb NIC can only handle the SCTP CRC
> > > > when it's in the outer packet, not in the inner packet like in this
> > > > case, so here it removes CRC flag from the dev features even when
> > > > need_csum is false.
> > >
> > > So the limitation in igb is not the hardware but the driver
> > > configuration. When I had coded things up I put in a limitation on the
> > > igb_tx_csum code that it would have to validate that the protocol we
> > > are requesting an SCTP CRC offload since it is a different calculation
> > > than a 1's complement checksum. Since igb doesn't support tunnels we
> > > limited that check to the outer headers.
> > Ah.. I see, thanks.
> > >
> > > We could probably enable this for tunnels as long as the tunnel isn't
> > > requesting an outer checksum offload from the driver.
> > I think in igb_tx_csum(), by checking skb->csum_not_inet would be enough
> > to validate that is a SCTP request:
> > -               if (((first->protocol == htons(ETH_P_IP)) &&
> > -                    (ip_hdr(skb)->protocol == IPPROTO_SCTP)) ||
> > -                   ((first->protocol == htons(ETH_P_IPV6)) &&
> > -                    igb_ipv6_csum_is_sctp(skb))) {
> > +               if (skb->csum_not_inet) {
> >                         type_tucmd = E1000_ADVTXD_TUCMD_L4T_SCTP;
> >                         break;
> >                 }
> >
>
> So if I may ask. Why go with something like csum_not_inet instead of
> specifying something like crc32_csum? I'm just wondering if there are
> any other non-1's complement checksums that we are dealing with?
I don't think there is, here is the thread of that patch:

https://lore.kernel.org/netdev/CALx6S36rem=OuN_At6qYA=se5cpuYM1N2R8efoaszvo8b8Tz5A@mail.gmail.com/

I'm writing GRE checksum, and trying to change csum_not_inet:1 to
csum_type:2, by doing the below, no bit hole occurs:

-       __u8                    csum_not_inet:1;
-       __u8                    dst_pending_confirm:1;
+       __u8                    csum_type:2;
 #ifdef CONFIG_IPV6_NDISC_NODETYPE
        __u8                    ndisc_nodetype:2;
 #endif
+       __u8                    dst_pending_confirm:1;

and in skb_csum_hwoffload_help():
 int skb_csum_hwoffload_help(struct sk_buff *skb,
                            const netdev_features_t features)
 {
-       if (unlikely(skb->csum_not_inet))
-               return !!(features & NETIF_F_SCTP_CRC) ? 0 :
-                       skb_crc32c_csum_help(skb);
+       if (likely(!skb->csum_type))
+               return !!(features & NETIF_F_CSUM_MASK) ? 0 :
skb_checksum_help(skb);
+
+       if (skb->csum_type == CSUM_T_GENERIC) {
+               return !!(features & NETIF_F_HW_CSUM) ? 0 :
skb_checksum_help(skb);
+       } else if (skb->csum_type == CSUM_T_SCTP_CRC) {
+               return !!(features & NETIF_F_SCTP_CRC) ? 0 :
skb_crc32c_csum_help(skb);
+       } else {
+               pr_warn("Wrong csum type: %d\n", skb->csum_type);
+               return 1;
+       }

then the driver fix will be:
        case offsetof(struct sctphdr, checksum):
                /* validate that this is actually an SCTP request */
-               if (((first->protocol == htons(ETH_P_IP)) &&
-                    (ip_hdr(skb)->protocol == IPPROTO_SCTP)) ||
-                   ((first->protocol == htons(ETH_P_IPV6)) &&
-                    igb_ipv6_csum_is_sctp(skb))) {
+               if (skb->csum_type == CSUM_T_SCTP_CRC) {
                        type_tucmd = E1000_ADVTXD_TUCMD_L4T_SCTP;
                        break;
                }

then the gre csum set will be:
+                               skb->csum_type = CSUM_T_GENERIC;
+                               skb->ip_summed = CHECKSUM_PARTIAL;
+                               skb->csum_start =
skb_transport_header(skb) - skb->head;
+                               skb->csum_offset = sizeof(*greh);

>
> One thing we might want to do to make eventual backporting for this
> easier would be to add an accessor inline function. Maybe something
> like a skb_csum_is_crc32() so that for older kernels the function
> could just be defined to return false since the csum_not_inet may not
> exist.
>
> > Otherwise, we will need to parse the packet a little bit, as it does in
> > hns3_get_l4_protocol().
>
> Agreed. If the csum_not_inet means it is a crc32 checksum then we
> could just look at the offsets and as long as they are correct for
> sctp we could just go forward with what we have.
>
> > >
> > > > v1->v2:
> > > >   - improve the changelog.
> > > >   - fix "rev xmas tree" in varibles declaration.
> > > >
> > > > Signed-off-by: Xin Long <lucien.xin@gmail.com>
> > > > ---
> > > >  net/ipv4/gre_offload.c | 15 ++++-----------
> > > >  1 file changed, 4 insertions(+), 11 deletions(-)
> > > >
> > > > diff --git a/net/ipv4/gre_offload.c b/net/ipv4/gre_offload.c
> > > > index e0a2465..a681306 100644
> > > > --- a/net/ipv4/gre_offload.c
> > > > +++ b/net/ipv4/gre_offload.c
> > > > @@ -15,10 +15,10 @@ static struct sk_buff *gre_gso_segment(struct sk_buff *skb,
> > > >                                        netdev_features_t features)
> > > >  {
> > > >         int tnl_hlen = skb_inner_mac_header(skb) - skb_transport_header(skb);
> > > > -       bool need_csum, need_recompute_csum, gso_partial;
> > > >         struct sk_buff *segs = ERR_PTR(-EINVAL);
> > > >         u16 mac_offset = skb->mac_header;
> > > >         __be16 protocol = skb->protocol;
> > > > +       bool need_csum, gso_partial;
> > > >         u16 mac_len = skb->mac_len;
> > > >         int gre_offset, outer_hlen;
> > > >
> > > > @@ -41,10 +41,11 @@ static struct sk_buff *gre_gso_segment(struct sk_buff *skb,
> > > >         skb->protocol = skb->inner_protocol;
> > > >
> > > >         need_csum = !!(skb_shinfo(skb)->gso_type & SKB_GSO_GRE_CSUM);
> > > > -       need_recompute_csum = skb->csum_not_inet;
> > > >         skb->encap_hdr_csum = need_csum;
> > > >
> > > >         features &= skb->dev->hw_enc_features;
> > > > +       /* CRC checksum can't be handled by HW when SCTP is the inner proto. */
> > > > +       features &= ~NETIF_F_SCTP_CRC;
> > > >
> > > >         /* segment inner packet. */
> > > >         segs = skb_mac_gso_segment(skb, features);
> > >
> > > Do we have NICs that are advertising NETIF_S_SCTP_CRC as part of their
> > > hw_enc_features and then not supporting it? Based on your comment
> > Yes, igb/igbvf/igc/ixgbe/ixgbevf, they have a similar code of SCTP
> > proto validation.
>
> Yeah, it is old code. It was added in 4.6 before tunnels supported
> SCTP_CRC I am guessing. It looks like csum_not_inet wasn't added until
> 4.13. So it would probably be best to fix the drivers since the driver
> code is outdated.
>
> > > above it seems like you are masking this out because hardware is
> > > advertising features it doesn't actually support. I'm just wondering
> > > if that is the case or if this is something where this should be
> > > cleared if need_csum is set since we only support one level of
> > > checksum offload.
> > Since only these drivers only do SCTP proto validation, and "only
> > one level checksum offload" issue only exists when inner packet
> > is SCTP packet, clearing NETIF_F_SCTP_CRC should be enough.
> >
> > But seems to fix the drivers will be better, as hw_enc_features should
> > tell the correct features for inner proto. wdyt?
>
> Yes, it would be better to fix the drivers. However the one limitation
> is that this will only work when we don't have an outer checksum in
> place. If we have an outer checksum then we have to compute the crc32
> checksum and then offload the outer checksum if we can.
>
> > (Just note udp tunneling SCTP doesn't have this issue, as the outer
> >  udp checksum is always required by RFC)
But sctp over Vxlan/Geneve may still use noudpcsum, so need_csum
may still be false in there.

vxlan and geneve is not supporting fraglist, which sctp hw gso requires.
I will add NETIF_F_FRAGLIST flag for udp tunnel device in another patch.

Thanks.

>
> Thanks. I wasn't aware of that.
>
> > >
> > > > @@ -99,15 +100,7 @@ static struct sk_buff *gre_gso_segment(struct sk_buff *skb,
> > > >                 }
> > > >
> > > >                 *(pcsum + 1) = 0;
> > > > -               if (need_recompute_csum && !skb_is_gso(skb)) {
> > > > -                       __wsum csum;
> > > > -
> > > > -                       csum = skb_checksum(skb, gre_offset,
> > > > -                                           skb->len - gre_offset, 0);
> > > > -                       *pcsum = csum_fold(csum);
> > > > -               } else {
> > > > -                       *pcsum = gso_make_checksum(skb, 0);
> > > > -               }
> > > > +               *pcsum = gso_make_checksum(skb, 0);
> > > >         } while ((skb = skb->next));
> > > >  out:
> > > >         return segs;
> > > > --
> > > > 2.1.0
> > > >
