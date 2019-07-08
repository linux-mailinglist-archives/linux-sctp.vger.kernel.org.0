Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C56A261F01
	for <lists+linux-sctp@lfdr.de>; Mon,  8 Jul 2019 14:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbfGHMyy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-sctp@lfdr.de>); Mon, 8 Jul 2019 08:54:54 -0400
Received: from mail-n.franken.de ([193.175.24.27]:58845 "EHLO drew.franken.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729038AbfGHMyy (ORCPT <rfc822;linux-sctp@vger.kernel.org>);
        Mon, 8 Jul 2019 08:54:54 -0400
Received: from [IPv6:2a02:c6a0:4015:12:f4a0:506f:aa54:cf8] (unknown [IPv6:2a02:c6a0:4015:12:f4a0:506f:aa54:cf8])
        (Authenticated sender: lurchi)
        by mail-n.franken.de (Postfix) with ESMTPSA id ED7A3721E281A;
        Mon,  8 Jul 2019 14:54:50 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: Support for RFC 6951 (UDP encapsulation for SCTP)
From:   Michael Tuexen <Michael.Tuexen@lurchi.franken.de>
In-Reply-To: <044c9c5b-a7a2-effa-7a07-8bea5edcb9c3@patfab.net>
Date:   Mon, 8 Jul 2019 14:54:50 +0200
Cc:     linux-sctp@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <62EDF8B4-3E01-4657-8C67-506C1ADE931C@lurchi.franken.de>
References: <044c9c5b-a7a2-effa-7a07-8bea5edcb9c3@patfab.net>
To:     Patrick Schultz <Patrick@patfab.net>
X-Mailer: Apple Mail (2.3445.104.11)
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=disabled version=3.4.1
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on mail-n.franken.de
Sender: linux-sctp-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

> On 8. Jul 2019, at 01:21, Patrick Schultz <Patrick@patfab.net> wrote:
> 
> Hello all,
> 
> are there already plans to support UDP encapsulation in lksctp-tools according to RFC6951?
Just for interop testing: FreeBSD supports this.

Best regards
Michael
> 
> Best regards,
> Patrick
> 
> 

